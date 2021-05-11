class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.8.1",
    revision: "e1601447477c38ceb46c9c88418af399f79b1d6a"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containerd/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.8.1_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "254b91c84c019c59d052185f1b77e194a4ec1c0baf7060ff83e0338986ebef81"
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
