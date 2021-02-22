class DockerBin < Formula
  desc "Docker CLI"
  homepage "https://www.docker.com"

  url "https://download.docker.com/linux/static/stable/x86_64/docker-20.10.3.tgz"
  sha256 "47065a47f0692cd5af03073c7386fe090d9ef5ac88a7d8455a884d8e15809be5"
  license "Apache-2.0"

  bottle :unneeded

  def install
    bin.install "docker"
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
