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
    tag:      "v20.10.8",
    revision: "75249d88bc107a122b503f6a50e89c994331867c"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-rootless-20.10.8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c5ba5aea323ad471efad8e4cfdaf08dfb85d3d858d5fe7a8bd974becbef96abd"
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
    (etc/"immortal").install "dockerd-rootless.yml"
  end

  def post_install
    (var/"run/dockerd").mkpath
    (var/"log").mkpath
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
