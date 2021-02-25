class Buildx < Formula
  desc "Docker CLI plugin for extended build capabilities with BuildKit"
  homepage "https://www.docker.com"

  url "https://github.com/docker/buildx.git",
    tag:      "v0.5.1",
    revision: "11057da37336192bfc57d81e02359ba7ba848e4a"
  license "Apache-2.0"
  revision 1
  head "https://github.com/docker/buildx.git"

  depends_on "go" => :build

  def install
    system "make", "binaries"

    bin.install "bin/buildx" => "docker-buildx"
  end

  def caveats
    <<~EOS
      You should create a symlink to enable the Docker CLI plugin:

      mkdir -p $HOME/.docker/cli-plugins
      ln -s #{lib}/docker/cli-plugins/docker-buildx $HOME/.docker/cli-plugins
    EOS
  end

  test do
    system "#{bin}/docker-buildx", "version"
  end
end
