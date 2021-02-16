class KubeswitchBin < Formula
  desc "Visually select kubernetes context/namespace from tree"
  homepage "https://github.com/danielb42/kubeswitch"

  url "https://github.com/danielb42/kubeswitch/releases/download/v1.3.2/kubeswitch_linux_amd64.tar.gz"
  version "1.3.2"
  sha256 "65544a7ebd977556b596ec2c4f6f4b9ecfdbc092f82fc19ece13c0b8651153e8"
  license ""

  bottle :unneeded

  def install
    bin.install "kubeswitch"
  end

  test do
    system "#{bin}/kubeswitch", "--help"
  end
end
