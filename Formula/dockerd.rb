class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.3",
    revision: "46229ca1d815cfd4b50eb377ac75ad8300e13a85"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git"

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
