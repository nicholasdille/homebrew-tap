class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.4.0",
    revision: "6e8de00bb224f9931d7402648f0177e7357ed079"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-3.3.1_1"
    sha256 cellar: :any_skip_relocation, catalina:     "37829beba1b34f44c664ac0223713f667f6f37e2e1bb0dceedd0b55b38120694"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "25c05296c2957a5178f48269e9379e7fbeb41e2ae2d761e148aad499419ab39e"
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
