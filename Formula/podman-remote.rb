class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.2.1",
    revision: "152952fe6b18581615c3efd1fafef2d8142738e8"
  license "Apache-2.0"
  revision 2
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-3.2.1_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "821181072214982ea678062c6426acfa3b1b5337636157b5a77c9e70b0a8c618"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ad1135e5a81c7d19acf23eca0b044ee6c2b169022983caebcb65a216e88bc40c"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build

  conflicts_with "podman"
  conflicts_with "nicholasdille/tap/podman-static"
  # conflicts_with "nicholasdille/tap/podman"

  def install
    system "make", "podman-remote-static"
    on_linux do
      bin.install "bin/podman-remote-static" => "podman"
    end
    on_macos do
      bin.install "bin/darwin/podman-remote-static" => "podman"
    end

    system "make", "docs", "GOMD2MAN=go-md2man"
    man1.install Dir["docs/build/man/*.1"]

    bash_completion.install "completions/bash/podman-remote"
    zsh_completion.install "completions/zsh/_podman-remote"
    fish_completion.install "completions/fish/podman-remote.fish"
  end

  test do
    assert_match "podman version #{version}", shell_output("#{bin}/podman -v")
  end
end
