class Buildkitd < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit.git",
    tag:      "v0.9.3",
    revision: "8d2625494a6a3d413e3d875a2ff7dd9b1ed1b1a9"
  license "Apache-2.0"
  head "https://github.com/moby/buildkit.git",
    branch: "master"

  livecheck do
    url :stable
    regex(/^v(.+)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildkitd-0.9.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "934791ef55b84ec44277b9a2f52de027fa635efd92a3fd73884dd50c7fa6bcfb"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/binfmt"
  depends_on "nicholasdille/tap/runc"

  conflicts_with "buildkit"

  resource "qemu" do
    url "https://github.com/tonistiigi/binfmt/releases/download/deploy%2Fv6.1.0-20/qemu_v6.1.0_linux-amd64.tar.gz"
    sha256 "ab68728bd57d9cec2e9ecd01eaa2980fff0d14d24e7ac829cb4d452651b3b785"
  end

  def install
    pkg = "github.com/moby/buildkit"
    commit = Utils.git_short_head
    ldflags = "-X #{pkg}/version.Version=#{version} -X #{pkg}/version.Revision=#{commit} -X #{pkg}/version.Package=#{pkg}"

    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      "-ldflags", ldflags,
      "-o", bin/"buildctl",
      "./cmd/buildctl"

    system "go", "build",
      "-ldflags", "#{ldflags} -extldflags -static",
      "-tags", "osusergo netgo static_build seccomp",
      "-o", bin/"buildkitd",
      "./cmd/buildkitd"

    resource("qemu").stage do
      bin.install Dir["qemu-*"]
    end

    (buildpath/"buildkitd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/buildkitd
      env:
        XDG_RUNTIME_DIR: #{var}/run/buildkitd
      pid:
        parent: #{var}/run/buildkitd/parent.pid
        child: #{var}/run/buildkitd/child.pid
      log:
        file: #{var}/log/buildkitd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    pkgshare.install "buildkitd.yml"

    (buildpath/"buildkit-init").write <<~EOS
      #!/bin/sh
      set -e

      ### BEGIN INIT INFO
      # Provides:           buildkit
      # Required-Start:     $syslog $remote_fs
      # Required-Stop:      $syslog $remote_fs
      # Default-Start:      2 3 4 5
      # Default-Stop:       0 1 6
      # Short-Description:  Create lightweight, portable, self-sufficient containers.
      # Description:
      #  Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit
      ### END INIT INFO

      export PATH=/home/linuxbrew/.linuxbrew/bin:/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin

      BASE=buildkit

      # modify these in /etc/default/$BASE
      BUILDKITD=/home/linuxbrew/.linuxbrew/bin/buildkitd
      # This is the pid file managed by BuildKit itself
      BUILDKIT_PIDFILE=/var/run/$BASE.pid
      # This is the pid file created/managed by start-stop-daemon
      BUILDKIT_SSD_PIDFILE=/var/run/$BASE-ssd.pid
      BUILDKIT_LOGFILE=/var/log/$BASE.log
      BUILDKIT_OPTS=
      BUILDKIT_DESC="BuildKit"

      # Get lsb functions
      . /lib/lsb/init-functions

      if [ -f /etc/default/$BASE ]; then
        . /etc/default/$BASE
      fi

      # Check daemon is present
      if [ ! -x $BUILDKITD ]; then
        log_failure_msg "$BUILDKITD not present or not executable"
        exit 1
      fi

      # Check group is present
      if ! cat /etc/group | grep -q "^$BASE:"; then
        log_failure_msg "Group $BASE not present"
        exit 1
      fi

      check_init() {
        # see also init_is_upstart in /lib/lsb/init-functions (which isn't available in Ubuntu 12.04, or we'd use it directly)
        if [ -x /sbin/initctl ] && /sbin/initctl version 2> /dev/null | grep -q upstart; then
          log_failure_msg "$BUILDKIT_DESC is managed via upstart, try using service $BASE $1"
          exit 1
        fi
      }

      fail_unless_root() {
        if [ "$(id -u)" != '0' ]; then
          log_failure_msg "$BUILDKIT_DESC must be run as root"
          exit 1
        fi
      }

      case "$1" in
        start)
          check_init

          fail_unless_root

          touch "$BUILDKIT_LOGFILE"
          chgrp "$BASE" "$BUILDKIT_LOGFILE"

          log_begin_msg "Starting $BUILDKIT_DESC: $BASE"
          start-stop-daemon --start --background \
            --no-close \
            --exec "$BUILDKITD" \
            --pidfile "$BUILDKIT_SSD_PIDFILE" \
            --make-pidfile \
            -- \
            $BUILDKIT_OPTS \
            >> "$BUILDKIT_LOGFILE" 2>&1
          result=$?
          if test "$?" == "0"; then
              while ! test -S "/run/$BASE/${BASE}d.sock"; do
                  sleep 1
              done
              chgrp "$BASE" "/run/$BASE" "/run/$BASE/${BASE}d.sock"
          fi
          log_end_msg $result
          ;;

        stop)
          check_init
          fail_unless_root
          if [ -f "$BUILDKIT_SSD_PIDFILE" ]; then
            log_begin_msg "Stopping $BUILDKIT_DESC: $BASE"
            start-stop-daemon --stop --pidfile "$BUILDKIT_SSD_PIDFILE" --retry 10
            log_end_msg $?
          else
            log_warning_msg "$BUILDKIT_DESC already stopped - file $BUILDKIT_SSD_PIDFILE not found."
          fi
          ;;

        restart)
          check_init
          fail_unless_root
          daemon_pid=$(cat "$BUILDKIT_SSD_PIDFILE" 2> /dev/null)
          [ -n "$daemon_pid" ] \
            && ps -p $daemon_pid > /dev/null 2>&1 \
            && $0 stop
          $0 start
          ;;

        force-reload)
          check_init
          fail_unless_root
          $0 restart
          ;;

        status)
          check_init
          status_of_proc -p "$BUILDKIT_SSD_PIDFILE" "$BUILDKITD" "$BUILDKIT_DESC"
          ;;

        *)
          echo "Usage: service $BASE {start|stop|restart|status}"
          exit 1
          ;;
      esac
    EOS
    chmod 0755, "buildkit-init"
    pkgshare.install "buildkit-init"

    (buildpath/"buildkit-default").write <<~EOS
      # Daemon Upstart and SysVinit configuration file

      #
      # THIS FILE DOES NOT APPLY TO SYSTEMD
      #
      #   Please see the documentation for "systemd drop-ins":
      #   https://docs.docker.com/engine/admin/systemd/
      #

      # Customize location of daemon binary (especially for development testing).
      #BUILDKITD="/usr/local/bin/dockerd"

      # Use BUILDKIT_OPTS to modify the daemon startup options.
      #DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"

      # If you need to use an HTTP proxy, it can also be specified here.
      #export http_proxy="http://127.0.0.1:3128/"
    EOS
    pkgshare.install "buildkit-default"
  end

  def post_install
    mkdir_p etc/"immortal"
    mkdir_p etc/"init.d"
    mkdir_p etc/"default"
    cp pkgshare/"buildkitd.yml", etc/"immortal"
    cp pkgshare/"buildkit-init", etc/"init.d/buildkit"
    cp pkgshare/"buildkit-default", etc/"default/buildkit"
  end

  def caveats
    <<~EOS
      Enable cross-building container images:

        sudo env QEMU_BINARY_PATH="#{HOMEBREW_PREFIX}/bin" #{HOMEBREW_PREFIX}/bin/binfmt --install all

      You can now run a rootful buildkitd.

      Option 1:
      - Copy #{etc}/init.d/buildkit /etc/init.d/buildkit
      - sudo service buildkit start

      Option 2:
      - brew tap nicholasdille/service
      - brew service install buildkit
      - brew service start buildkit
    EOS
  end

  test do
    system bin/"buildkitd", "--version"
  end
end
