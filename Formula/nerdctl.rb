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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.6.0_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "39781b31dd5c6d0396ba3f698a7f8d92c90d6593b9888e381db9076e7b278681"
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
