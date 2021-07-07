class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.2.2",
    revision: "d577c44e359f9f8284b38cf984f939b3020badc3"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-3.2.2"
    sha256 cellar: :any_skip_relocation, catalina:     "f3aeabe18f6780c5d3f2561e9f314acf96f8f90d96b7ed53009ed44eeaa5e6db"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8a8f71bb5c7bb9d6792f0d17c215a772179c3b65f366f30017509aaa583bbedb"
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
