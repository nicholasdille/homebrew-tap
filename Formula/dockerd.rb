class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.7",
    revision: "b0f5bc36fea9dfb9672e1e9b1278ebab797b9ee0"
  license "Apache-2.0"
  revision 1
  head "https://github.com/moby/moby.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-20.10.7"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6bdf2a17094107efc338973312635badf6bad29733f66dacabf33586c30f37c"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/runc"
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
