class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.6",
    revision: "8728dd246c3ab53105434eef8ffe997b6fd14dc6"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-20.10.5_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cc425af7f6e1427d8476bf17c36f33f5cc2ef7f7029ed8989386a4b6fa0daaf9"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
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
