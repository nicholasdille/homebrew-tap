class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.9",
    revision: "79ea9d3080181d755855d5924d0f4f116faa9463"
  license "Apache-2.0"
  revision 1
  head "https://github.com/moby/moby.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-20.10.9_1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, x86_64_linux: "33d6ad427fc96870c24f9385a02989583b77677c32ba32a526d7dc525919d8d0"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "nicholasdille/tap/docker" => :build
  depends_on "pkg-config" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/buildx"
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/docker-proxy"
  depends_on "nicholasdille/tap/runc"
  depends_on "nicholasdille/tap/tini"
  depends_on "device-mapper" => :optional

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["GO111MODULE"] = "auto"

    buildtags = []
    buildtags << "exclude_graphdriver_btrfs" if build.without? "btrfs"

    ENV["VERSION"] = version
    ENV["DOCKER_BUILDTAGS"] = buildtags.join(" ")
    system "./hack/make.sh", "binary"
    bin.install "bundles/binary-daemon/dockerd-#{version}" => "dockerd"

    inreplace "contrib/init/sysvinit-debian/docker", "export PATH=", "export PATH=/home/linuxbrew/.linuxbrew/bin:"
    inreplace "contrib/init/sysvinit-debian/docker",
      "DOCKERD=/usr/bin/dockerd",
      "DOCKERD=/home/linuxbrew/.linuxbrew/bin/dockerd"
    (etc/"init.d").install "contrib/init/sysvinit-debian/docker"
    (etc/"default").install "contrib/init/sysvinit-debian/docker.default" => "docker"

    (buildpath/"daemon.json").write <<~EOS
      {
        "features": {
          "buildkit": true
        }
      }
    EOS
    (etc/"docker").install "daemon.json"

    (buildpath/"dockerd.yml").write <<~EOS
      cmd: #{bin}/dockerd --config-file #{etc}/docker/daemon.json
      cwd: #{etc}/docker
      env:
        XDG_RUNTIME_DIR: #{var}/run/dockerd
      pid:
        parent: #{var}/run/dockerd/parent.pid
        child: #{var}/run/dockerd/child.pid
      log:
        file: #{var}/log/dockerd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
      require:
      - containerd
    EOS
    (etc/"immortal").install "dockerd.yml"
  end

  def post_install
    ln_s HOMEBREW_PREFIX/"bin/tini", bin/"docker-init"
  end

  def caveats
    output = Utils.safe_popen_read("iptables", "--version")
    if output.include? "legacy"
      <<~EOS
        You must switch to legacy iptables to use dockerd.
      EOS
    end
  end

  test do
    system bin/"dockerd", "--version"
  end
end
