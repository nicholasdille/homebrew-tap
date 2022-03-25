class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.18.0",
    revision: "77276ff0fffad3f855ab9f2f5a4ad5527ef76485"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.17.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8ef8ac255759718adbd5db80045dd4ee8859f84dd5a28afd31203064d9b83367"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    system "make"
    bin.install "_output/nerdctl"

    # bash completion
    ENV["XDG_RUNTIME_DIR"] = "/tmp"
    output = Utils.safe_popen_read(bin/"nerdctl", "completion", "bash")
    (bash_completion/"nerdctl").write output
  end

  def post_install
    (var/"run/nerdctl").mkpath
  end

  test do
    system bin/"nerdctl", "--version"
  end
end
