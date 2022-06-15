class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v4.1.1",
    revision: "f73d8f8875c2be7cd2049094c29aff90b1150241"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-4.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "4d0ec5116d6488e21b62d411949f84d3f8a2fe40474b7918f02eab2d9362f218"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c403963e3a446fbcb81c0a2c3ebc07a67275f5cce1715dd9b56040daa524166d"
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
