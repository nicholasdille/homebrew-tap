class CriO < Formula
  desc "OCI-based implementation of Kubernetes Container Runtime Interface"
  homepage "https://cri-o.io/"

  url "https://github.com/cri-o/cri-o.git",
    tag:      "v1.21.2",
    revision: "aaefa6b173f79384c6a2a627e5074a7f5b02957f"
  license "Apache-2.0"
  head "https://github.com/cri-o/cri-o.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cri-o-1.21.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7537ace7c45159e24299f93d1e93c8e660fc3d76cef118e1b9151dbc38c1b5db"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    ENV["CGO_ENABLED"] = "0"
    system "make", "binaries"
    bin.install "bin/crio"
    bin.install "bin/crio-status"
    bin.install "bin/pinns"

    system "make", "docs"
    man5.install Dir["docs/*.5"]
    man8.install Dir["docs/*.8"]

    # bash completion
    output = Utils.safe_popen_read("#{bin}/crio", "complete", "bash")
    (bash_completion/"crio").write output

    # fish completion
    output = Utils.safe_popen_read("#{bin}/crio", "complete", "fish")
    (zsh_completion/"crio.fish").write output

    # zsh completion
    output = Utils.safe_popen_read("#{bin}/crio", "complete", "zsh")
    (zsh_completion/"_crio").write output

    # bash completion
    output = Utils.safe_popen_read("#{bin}/crio-status", "complete", "bash")
    (bash_completion/"crio-status").write output

    # fish completion
    output = Utils.safe_popen_read("#{bin}/crio-status", "complete", "fish")
    (zsh_completion/"crio-status.fish").write output

    # zsh completion
    output = Utils.safe_popen_read("#{bin}/crio-status", "complete", "zsh")
    (zsh_completion/"_crio-status").write output
  end

  test do
    system bin/"crio", "--version"
  end
end
