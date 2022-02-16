class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.17.0",
    revision: "9ec475aeb69209b9b2a3811aee0923e2eafd1644"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.17.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "55af3344490d67daab5bfa240665d8073ffd63e9e72b94d928823c5bbaeb686d"
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
