class DockerProxy < Formula
  desc "Networking for containers"
  homepage "https://github.com/moby/libnetwork"

  url "https://github.com/moby/libnetwork.git",
    revision: "fa125a3512ee0f6187721c88582bf8c4378bd4d7"
  version "20.10.7"
  license "Apache-2.0"
  head "https://github.com/moby/libnetwork.git"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux

  conflicts_with "nicholasdille/dockerd"

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
