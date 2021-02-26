class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.3",
    revision: "46229ca1d815cfd4b50eb377ac75ad8300e13a85"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-20.10.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2f972528e97ff7dc8fcccfe9c62f8e814dbf6f70f607196a53526ce72b133993"
  end

  depends_on "go" => :build
  depends_on "pkg-config" => :build

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["GO111MODULE"] = "auto"

    system "make", "binary", "VERSION=#{version}"

    bin.install "bundles/binary-daemon/dockerd-#{version}" => "dockerd"
    bin.install "bundles/binary-daemon/docker-proxy"
    bin.install "bundles/binary-daemon/docker-init"
  end

  test do
    system "#{bin}/dockerd", "--version"
  end
end
