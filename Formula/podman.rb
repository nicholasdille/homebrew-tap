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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-3.1.2"
    sha256 cellar: :any_skip_relocation, catalina:     "63d200e607855278800883b7ef38f78ffa5afcffa237cf5cf580a656fc2a24d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce6257e3eb9422958d5fa01d8099383ca3e50f447a078a7a096bef69c4591736"
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
