class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.1.2",
    revision: "51b8ddbc22cf5b10dd76dd9243924aa66ad7db39"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-3.1.1"
    sha256 cellar: :any_skip_relocation, catalina:     "52f95f5caca4a3312990a3bc7c29fca6f531c8df50a1f3f34e5a3d7e924e8a73"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92752b0831d6ca9a0b2bb0dba437b604a4e7bb410bb943193f4953804568a307"
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
