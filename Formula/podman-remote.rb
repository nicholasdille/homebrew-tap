class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.2.1",
    revision: "152952fe6b18581615c3efd1fafef2d8142738e8"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-3.2.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8ffa33fa05407e03939c326a747e4ab488a0080e33e56589171199969204e5d"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build

  conflicts_with "podman"
  conflicts_with "nicholasdille/tap/podman-static"
  # conflicts_with "nicholasdille/tap/podman"

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
