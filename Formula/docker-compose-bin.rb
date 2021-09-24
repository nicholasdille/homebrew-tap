class DockerComposeBin < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/docker/compose.git",
    tag:      "1.29.2",
    revision: "5becea4ca9f68875334c92f191a13482bcd6e5cf"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle :unneeded

  deprecate! date:    "2021-09-15",
             because: "Docker compose v2 now builds correctly"

  conflicts_with "docker-compose"

  resource "binary" do
    on_linux do
      url "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64"
      sha256 "f3f10cf3dbb8107e9ba2ea5f23c1d2159ff7321d16f0a23051d68d8e2547b323"
    end
    on_macos do
      url "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Darwin-x86_64"
      sha256 "ddfaf03c3aae5277cd5f611f1b33d1966157ed9d3545a98307ae78d40cbd9684"
    end
  end

  def install
    resource("binary").stage do |resource|
      bin.install resource.url.split("/")[-1] => "docker-compose"
    end

    bash_completion.install "contrib/completion/bash/docker-compose"
    fish_completion.install "contrib/completion/fish/docker-compose.fish"
    zsh_completion.install "contrib/completion/zsh/_docker-compose"
  end

  def caveats
    <<~EOS
      You are installing the Python-based docker-compose.
      Please consider using the new Go-based CLI-integrated compose-cli:

        brew install nicholasdille/tap/docker-compose-cli
    EOS
  end

  test do
    system bin/"docker-compose", "version"
  end
end
