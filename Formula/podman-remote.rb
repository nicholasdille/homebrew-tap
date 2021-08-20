class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.3.0",
    revision: "98f252a3a1a8f1ee00f9f96c6ba00500954b5093"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-3.3.0"
    sha256 cellar: :any_skip_relocation, catalina:     "607b04ad008c158505043b7e385fb046399e41c5ab3a79ecfc79aa75ca5dd35f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d4659a9094e3f8e92ff800c160b5e12fb48c99d55278110da29b3e5f45bc069"
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
