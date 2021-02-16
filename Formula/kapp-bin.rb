class KappBin < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp/releases/download/v0.35.0/kapp-linux-amd64"
  version "0.35.0"
  sha256 "0f9d4daa8c833a8e245362c77e72f4ed06d4f0a12eed6c09813c87a992201676"
  license "Apache-2.0"

  bottle :unneeded

  def install
    bin.install "kapp-linux-amd64" => "kapp"
  end

  test do
    system "#{bin}/kapp", "--version"
  end
end
