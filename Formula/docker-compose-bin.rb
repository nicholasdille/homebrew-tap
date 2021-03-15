class DockerComposeBin < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/docker/compose.git",
    tag:      "1.28.5",
    revision: "c4eb3a1f475ca486340d4d5314ddf47555b2b1c6"
  license "Apache-2.0"
  head "https://github.com/docker/compose.git"

  bottle :unneeded

  conflicts_with "docker-compose"

  resource "binary" do
    on_linux do
      url "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-Linux-x86_64"
      sha256 "46406eb5d8443cc0163a483fcff001d557532a7fad5981e268903ad40b75534c"
    end
    on_macos do
      url "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-Darwin-x86_64"
      sha256 "ddfaf03c3aae5277cd5f611f1b33d1966157ed9d3545a98307ae78d40cbd9684"
    end
  end

  def install
    resource("binary").stage do
      os = "Linux"  if OS.linux?
      os = "Darwin" if OS.mac?
      bin.install "docker-compose-#{os}-#{Hardware::CPU.arch}" => "docker-compose"
    end

    bash_completion.install "contrib/completion/bash/docker-compose"
    fish_completion.install "contrib/completion/fish/docker-compose.fish"
    zsh_completion.install "contrib/completion/zsh/_docker-compose"
  end

  test do
    system bin/"docker-compose", "version"
  end
end
