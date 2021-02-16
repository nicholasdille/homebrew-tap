class CniIsolationBin < Formula
  desc "CNI Bridge Isolation Plugin"
  homepage "https://github.com/containernetworking/plugins/issues/573"

  url "https://github.com/AkihiroSuda/cni-isolation/releases/download/v0.0.3/cni-isolation-amd64.tgz"
  version "0.0.3"
  sha256 "9f130b6c6d9fbcb8b962fe54f8c562efeb1b14686eb240125a1ab87e11ea5f21"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "nicholasdille/tap/cni-bin" => :recommended

  def install
    bin.install "isolation"
  end

  test do
    system "#{bin}/isolation"
  end
end
