class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.17",
    revision: "a89b84221c8560e7a3dee2a653353429e7628424"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-20.10.17"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "630536531687a2073baa32a00e0798a6ec12d3d72a388723fc2270117c28521e"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"

  depends_on "device-mapper" => :build
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

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["GO111MODULE"] = "auto"

    buildtags = []
    buildtags << "exclude_graphdriver_btrfs" if build.without? "btrfs"

    ENV["VERSION"] = version
    ENV["DOCKER_BUILDTAGS"] = buildtags.join(" ")
    system "./hack/make.sh", "binary"
    bin.install "bundles/binary-daemon/dockerd-#{version}" => "dockerd"

    inreplace "contrib/init/sysvinit-debian/docker",
      "export PATH=",
      "export PATH=/home/linuxbrew/.linuxbrew/bin:"
    inreplace "contrib/init/sysvinit-debian/docker",
      "DOCKERD=/usr/bin/dockerd",
      "DOCKERD=/home/linuxbrew/.linuxbrew/bin/dockerd"
    pkgshare.install "contrib/init/sysvinit-debian/docker" => "docker-init"
    pkgshare.install "contrib/init/sysvinit-debian/docker.default" => "docker-default"

    (buildpath/"daemon.json").write <<~EOS
      {
        "features": {
          "buildkit": true
        }
      }
    EOS
    pkgshare.install "daemon.json"

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
    pkgshare.install "dockerd.yml"
  end

  def post_install
    ln_sf HOMEBREW_PREFIX/"bin/tini", HOMEBREW_PREFIX/"bin/docker-init"
    mkdir_p etc/"init.d"
    cp pkgshare/"docker-init", etc/"init.d/docker"
    mkdir_p etc/"default"
    cp pkgshare/"docker-default", etc/"default/docker"
    mkdir_p etc/"docker"
    cp pkgshare/"daemon.json", etc/"docker"
    mkdir_p etc/"immortal"
    cp pkgshare/"dockerd.yml", etc/"immortal"
  end

  def caveats
    output = Utils.safe_popen_read("iptables", "--version")
    if output.exclude? "legacy"
      <<~EOS
        You must switch to legacy iptables to use dockerd.
      EOS
    end

    <<~EOS
      You can now run a rootful dockerd.

      Option 1:
      - Copy #{etc}/init.d/docker /etc/init.d/docker
      - sudo service docker start

      Option 2:
      - brew tap nicholasdille/service
      - brew service install docker
      - brew service start docker
    EOS
  end

  test do
    system bin/"dockerd", "--version"
  end
end
