class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.1.2",
    revision: "51b8ddbc22cf5b10dd76dd9243924aa66ad7db39"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-3.1.2_1"
    sha256 cellar: :any_skip_relocation, catalina:     "ffa029d462e2e5b3f45ce659d2eeab9e05c23081552fb8d16f934456a140976d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e9bf20730ebe9f67030d64cf3e12d2881758812f88420e7154eb68a4f3a29115"
  end

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
    assert_match "podman version #{version}", shell_output("#{bin}/podman -v")
  end
end
