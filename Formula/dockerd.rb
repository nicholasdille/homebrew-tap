class IptablesRequirement < Requirement
  fatal true

  satisfy(build_env: false) do
    output = Utils.safe_popen_read("iptables", "--version")
    output.include? "legacy"
  end

  def message
    <<~EOS
      Please switch to legacy iptables.
    EOS
  end
end

class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.7",
    revision: "b0f5bc36fea9dfb9672e1e9b1278ebab797b9ee0"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-20.10.6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc490e1dc9a4826a44bbbf7c3f11ffe15146d2c04501b83dcfb511d1f346e5a1"
  end

  depends_on "go" => :build
  depends_on linux: :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on IptablesRequirement
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/runc"

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["GO111MODULE"] = "auto"

    system "make", "binary", "VERSION=#{version}"

    bin.install "bundles/binary-daemon/dockerd-#{version}" => "dockerd"
    bin.install "bundles/binary-daemon/docker-proxy"
    bin.install "bundles/binary-daemon/docker-init"

    (buildpath/"daemon.json").write <<~EOS
      {
        "features": {
          "buildkit": true
        }
      }
    EOS
    (etc/"docker").install "daemon.json"
  end

  test do
    system bin/"dockerd", "--version"
  end
end
