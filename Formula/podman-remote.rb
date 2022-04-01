class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v4.0.3",
    revision: "62534053086fdeba7b93117e7c4dc6e797835a3e"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-4.0.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "5e4debd793e37e30f4e48bf58b53cd1ea340f2aee2af03922a1a100d532d0bde"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "da6fba9b24613d1ef635b6f54d52a12a09d15e69137b9bbcd375cebbfcd9832a"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build

  conflicts_with "podman"

  def install
    system "make", "podman-remote-static", "CGO_ENABLED=0"
    subdir = "" if OS.linux?
    subdir = "/darwin" if OS.mac?
    bin.install "bin#{subdir}/podman-remote-static" => "podman-remote"

    system "make", "docs", "GOMD2MAN=go-md2man"
    man1.install Dir["docs/build/man/*.1"]

    bash_completion.install "completions/bash/podman-remote"
    zsh_completion.install "completions/zsh/_podman-remote"
    fish_completion.install "completions/fish/podman-remote.fish"
  end

  test do
    system bin/"podman-remote", "-v"
  end
end
