class BuildxBin < Formula
  desc "Docker CLI plugin for extended build capabilities with BuildKit"
  homepage "https://www.docker.com"

  url "https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64"
  sha256 "5f1dda3ae598e82c3186c2766506921e6f9f51c93b5ba43f7b42b659db4aa48d"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "nicholasdille/tap/docker-bin"

  def install
    bin.install "buildx-v0.5.1.linux-amd64" => "docker-buildx"
  end

  test do
    system "#{bin}/buildx", "--version"
  end
end
