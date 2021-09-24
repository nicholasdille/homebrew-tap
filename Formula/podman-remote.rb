class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.3.1",
    revision: "4c5283fabff2de5145838f1847a5a7b2b1fbc0a5"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containers/podman.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-3.3.1"
    sha256 cellar: :any_skip_relocation, catalina:     "1646ef00498444e186a0ebe56aa7f8095cdcf52e08eb9b62d79bbdfbac143f0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c85ad0ea44c923c1aace127c65c01df20d68286f88cdcddedbe07cd087110cf8"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build

  conflicts_with "podman"

  def install
    system "make", "podman-remote-static"
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
