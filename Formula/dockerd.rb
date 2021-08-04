class Dockerd < Formula
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-20.10.7_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "51d2495dcef6b0ad6a0c8f2f93df81f984cde85b3fb34fa61f1d491210f37d3e"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/containerd@1.4"
  depends_on "nicholasdille/tap/runc@1.0.0-rc"
  depends_on "nicholasdille/tap/tini"

  conflicts_with "nicholasdille/tap/docker-proxy"

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["GO111MODULE"] = "auto"

    system "make", "binary", "VERSION=#{version}"

    bin.install "bundles/binary-daemon/dockerd-#{version}" => "dockerd"
    bin.install "bundles/binary-daemon/docker-proxy"
    ln_s HOMEBREW_PREFIX/"bin/tini", bin/"docker-init"

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
