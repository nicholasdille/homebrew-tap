class KappBin < Formula
  desc "kapp is a simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp/releases/download/v0.35.0/kapp-linux-amd64"
  version "0.35.0"
  sha256 ""
  license "Apache-2.0"

  bottle :unneeded

  def install
    bin.install "kapp-linux-amd64" => "kapp"
  end

  test do
    system "#{bin}/kapp", "--version"
  end
end
