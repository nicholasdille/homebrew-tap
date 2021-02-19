class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/AkihiroSuda/nerdctl"

  url "https://github.com/AkihiroSuda/nerdctl.git",
    tag:      "v0.6.0",
    revision: "3d61627985197a3c9518354e5a837998c3957176"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.5.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "df0b8d96f2a622878c798591af5da0c243fe2feb235f87ea0710875933857587"
  end

  depends_on "go" => :build
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/buildkit" => :recommended
  depends_on "nicholasdille/tap/cni" => :recommended
  depends_on "nicholasdille/tap/cni-isolation" => :recommended

  def install
    ENV["XDG_RUNTIME_DIR"] = var/"lib/nerdctl"
    system "make"
    bin.install "_output/nerdctl"
  end

  test do
    system "#{bin}/nerdctl", "--version"
  end
end
