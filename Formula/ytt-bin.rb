class YttBin < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io/"
  url "https://github.com/vmware-tanzu/carvel-ytt/archive/v0.31.0.tar.gz"
  version "0.30.0"
  sha256 "33257c771f9c067938521c8d3b86968b623242221881a1e92ff17c555d98d034"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  depends_on "go" => :build
  depends_on "zip" => :build

  conflicts_with "nicholasdille/tap/ytt"

  def install
    bin.install "ytt-linux-amd64" => "ytt"
  end

  test do
    system "#{bin}/ytt", "--version"
  end
end
