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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-4.0.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "ccb111d521ef957252446395de305de75a5450c871d447199e4eba7e91c571a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "93e18dbe58f3de45f871fb75c2a4f224dfab2bd8f5787f93f7d1539ada078679"
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
