class LinuxNewuidmapRequirement < Requirement
  fatal true

  satisfy(build_env: false) { which(TOOL).present? }

  def message
    <<~EOS
      Please install the uidmap package.
    EOS
  end

  TOOL = "newuidmap".freeze
end

class LinuxNewgidmapRequirement < Requirement
  fatal true

  satisfy(build_env: false) { which(TOOL).present? }

  def message
    <<~EOS
      Please install the uidmap package.
    EOS
  end

  TOOL = "newgidmap".freeze
end

class DockerdRootless < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.11",
    revision: "847da184ad5048b27f5bdf9d53d070f731b43180"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-rootless-20.10.11"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d2db70491bea3fbb3b9952fa5f57fb722d5d2fe2cebee2e7d9cfe7b0cd54743c"
  end

  depends_on "immortal"
  depends_on :linux
  depends_on LinuxNewgidmapRequirement
  depends_on LinuxNewuidmapRequirement
  depends_on "nicholasdille/tap/dockerd"
  depends_on "nicholasdille/tap/fuse-overlayfs-bin"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    bin.install "contrib/dockerd-rootless.sh"

    (buildpath/"dockerd-rootless.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/dockerd-rootless.sh --config-file #{etc}/docker/daemon.json
      cwd: #{etc}/docker
      env:
        XDG_RUNTIME_DIR: #{var}/run/dockerd-rootless
      pid:
        parent: #{var}/run/dockerd-rootless/parent.pid
        child: #{var}/run/dockerd-rootless/child.pid
      log:
        file: #{var}/log/dockerd-rootless.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    pkgshare.install "dockerd-rootless.yml"
  end

  def post_install
    mkdir_p etc/"immortal"
    cp pkgshare/"dockerd-rootless.yml", etc/"immortal"
    mkdir_p var/"run/dockerd"
    mkdir_p var/"log"
  end

  def caveats
    <<~EOS
      - You can manage rootless Docker using immortal:
          $ brew tap nicholasdille/immortal
          $ brew immortal --help
      - Make rootless Docker the default:
          $ docker context create rootless \
              --description "Docker Rootless" \
              --docker "host=unix://#{var}/run/dockerd/docker.sock"
          $ docker context use rootless
    EOS
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/dockerd", "--version"
  end
end
