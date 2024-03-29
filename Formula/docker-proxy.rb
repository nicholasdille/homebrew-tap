class DockerProxy < Formula
  desc "Networking for containers"
  homepage "https://github.com/moby/libnetwork"

  url "https://github.com/moby/libnetwork.git",
    revision: "64b7a4574d1426139437d20e81c0b6d391130ec8"
  version "20.10.9"
  license "Apache-2.0"
  head "https://github.com/moby/libnetwork.git",
    branch: "master"

  livecheck do
    skip "Manual version"
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-proxy-20.10.9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1f14b6dfefbf498c1612425d3d9cbb09e36969e8f03b5dbc05cf53b2e2ec2b84"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    dir = buildpath/"src/github.com/docker/libnetwork"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "off"
      ENV["CGO_ENABLED"] = "0"
      ENV["GOPATH"] = buildpath

      system "go", "build",
        "-buildmode=pie",
        "-ldflags", "-linkmode=external",
        "-o", bin/"docker-proxy",
        "github.com/docker/libnetwork/cmd/proxy"
    end
  end

  test do
    system bin/"docker-proxy", "--help"
  end
end
