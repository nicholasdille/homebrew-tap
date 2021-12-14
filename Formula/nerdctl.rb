class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.15.0",
    revision: "b72b5ca14550b2e23a42787664b6182524c5053f"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.14.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8f0d2949ed5e4619238991bb51e78d54b4e54fd0776638d0f960cd66fa32920f"
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
