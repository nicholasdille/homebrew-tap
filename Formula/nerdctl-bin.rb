class NerdctlBin < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/AkihiroSuda/nerdctl"

  url "https://github.com/AkihiroSuda/nerdctl/releases/download/v0.5.0/nerdctl-0.5.0-linux-amd64.tar.gz"
  version "0.5.0"
  sha256 "c37c8ba34194195ca240362a95fe6c61b1c4bd26a61c1afa2d83ecc35cdeb858"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "nicholasdille/tap/containerd-bin"
  depends_on "nicholasdille/tap/buildkit-bin" => :recommended
  depends_on "nicholasdille/tap/cni-bin" => :recommended
  depends_on "nicholasdille/tap/cni-isolation-bin" => :recommended

  def install
    bin.install "nerdctl"
  end

  test do
    system "#{bin}/buildkitd", "--version"
  end
end
