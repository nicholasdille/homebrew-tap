class YttBin < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io/"

  url "https://github.com/vmware-tanzu/carvel-ytt/releases/download/v0.30.0/ytt-linux-amd64"
  version "0.30.0"
  sha256 "456e58c70aef5cd4946d29ed106c2b2acbb4d0d5e99129e526ecb4a859a36145"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/ytt"

  def install
    bin.install "ytt-linux-amd64" => "ytt"
  end

  test do
    system "#{bin}/ytt", "--version"
  end
end
