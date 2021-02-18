class DockerBin < Formula
  desc "Docker CLI"
  homepage "https://www.docker.com"

  url "https://download.docker.com/linux/static/stable/x86_64/docker-20.10.2.tgz"
  sha256 "97017e32a8ecbdd1826bb3c7b1424303ee0dea3f900d33591b1df5e394ed4eed"
  license "Apache-2.0"

  bottle :unneeded

  def install
    bin.install "docker"
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
