class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.10.0",
    revision: "ad836c2f0f53084a762112be58379d8d795812a5"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.9.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2c267e081f9658f9ebc5edcf3b1617a8a9344cf74bc9440aaf3097cc3b41ea54"
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
