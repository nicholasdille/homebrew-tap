class FaasdBin < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "https://github.com/openfaas/faasd/releases/download/0.10.2/faasd"
  sha256 "6d2694f0297aa2ad95deb1fb8b13285aae064ab942d1f2ed8d341b5c7abaaae9"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "nicholasdille/tap/cni-bin"
  depends_on "nicholasdille/tap/containerd-bin"
  depends_on "faas-cli" => :recommended

  def install
    bin.install "faasd"
  end

  test do
    system "#{bin}/faasd", "--version"
  end
end
