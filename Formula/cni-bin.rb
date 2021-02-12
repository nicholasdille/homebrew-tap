class CniBin < Formula
  desc "Some reference and example networking plugins, maintained by the CNI team"
  homepage "https://github.com/containernetworking/plugins"

  url "https://github.com/containernetworking/plugins/releases/download/v0.9.1/cni-plugins-linux-amd64-v0.9.1.tgz"
  version "0.9.1"
  sha256 "962100bbc4baeaaa5748cdbfce941f756b1531c2eadb290129401498bfac21e7"
  license "Apache-2.0"

  bottle :unneeded

  def install
    bin.install buildpath.children
  end

  test do
    system "#{bin}/loopback"
  end
end
