class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.1.0",
    revision: "9f09fb62cba8f44c18eda84db3e72aab3ae76046"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-3.1.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d72fd44712fb7b9d8580db4f96ff5fd84b7ba61b3e267dd807ec3a01dab70a1a"
  end

  depends_on "git" => :build
  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "podman-remote-static"
    bin.install "bin/podman-remote-static" => "podman"

    system "make", "docs"
    man1.install Dir["docs/build/man/*.1"]

    bash_completion.install "completions/bash/podman"
    zsh_completion.install "completions/zsh/_podman"
  end

  test do
    system bin/"podman", "--version"
  end
end
