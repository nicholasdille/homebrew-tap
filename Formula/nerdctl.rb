class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/AkihiroSuda/nerdctl"

  url "https://github.com/AkihiroSuda/nerdctl.git",
    tag:      "v0.6.0",
    revision: "3d61627985197a3c9518354e5a837998c3957176"
  license "Apache-2.0"
  revision 1
  head "https://github.com/AkihiroSuda/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.6.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec2081983fae8fa152fabbb8ddf32fd9b33812aa068628eaa67f210ddd7e9547"
  end

  depends_on "go" => :build
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/buildkitd" => :recommended
  depends_on "nicholasdille/tap/cni" => :recommended
  depends_on "nicholasdille/tap/cni-isolation" => :recommended

  def install
    system "make"
    bin.install "_output/nerdctl"
    (var/"lib/nerdctl").mkpath
  end

  test do
    ENV["XDG_RUNTIME_DIR"] = var/"lib/nerdctl"
    system "#{bin}/nerdctl", "--version"
  end
end
