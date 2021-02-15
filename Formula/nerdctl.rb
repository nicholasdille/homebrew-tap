class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/AkihiroSuda/nerdctl"

  url "https://github.com/AkihiroSuda/nerdctl.git",
    tag:      "v0.5.0",
    revision: "6afd80b0200930d30b0bc30c56768d5a1b8d6ebb"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/nerdctl.git"

  depends_on "go" => :build
  depends_on "nicholasdille/tap/containerd-bin"
  depends_on "nicholasdille/tap/buildkit-bin" => :recommended
  depends_on "nicholasdille/tap/cni-bin" => :recommended
  depends_on "nicholasdille/tap/cni-isolation-bin" => :recommended

  def install
    system "make"
    bin.install "_output/nerdctl"
  end

  test do
    system "#{bin}/nerdctl", "--version"
  end
end
