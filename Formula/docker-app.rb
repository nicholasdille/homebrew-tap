class DockerApp < Formula
  desc "Make your Docker Compose applications reusable, and share them on Docker Hub"
  homepage "https://github.com/docker/app"

  url "https://github.com/docker/app.git",
    tag:      "v0.9.1-beta3",
    revision: "9d2c67f87b7338eb1a0fa2f18eb81af3d2aac0e1"
  license "Apache-2.0"
  head "https://github.com/docker/app.git"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-app-0.9.1-beta3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ad51dd21a84dda2710719f343dfcbe2b1a76f20684c899c5e6e38330eb06c9d3"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    dir = buildpath/"src/github.com/docker/app"
    dir.install (buildpath/"").children
    cd dir do
      system "make", "bin/docker-app"
      bin.install "bin/docker-app"
    end
  end

  def caveats
    <<~EOS
      You should create a symlink to enable the Docker CLI plugin:

      mkdir -p $HOME/.docker/cli-plugins
      ln -s #{lib}/docker/cli-plugins/docker-app $HOME/.docker/cli-plugins
    EOS
  end

  test do
    system bin/"docker-app", "app", "--version"
  end
end
