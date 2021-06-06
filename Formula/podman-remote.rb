class PodmanRemote < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.2.0",
    revision: "0281ef262dd0ffae28b5fa5e4bdf545f93c08dc7"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-remote-3.1.2"
    sha256 cellar: :any_skip_relocation, catalina:     "151d44c455ffb07fd8ad665ed7eada591398f6076484a2b37673f4ec5a4c313a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "27893ed064f64a92e8300a898ae2cfbc6556327d1dafab021fb7af281aeb3c34"
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
