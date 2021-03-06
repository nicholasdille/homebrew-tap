class CniDnsname < Formula
  desc "Name resolution for containers"
  homepage "https://github.com/containers/dnsname"

  url "https://github.com/containers/dnsname.git",
    tag:      "v1.2.0",
    revision: "3b29247c46d2811610ad57dd9fdae61157532a5b"
  license "Apache-2.0"
  head "https://github.com/containers/dnsname.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-dnsname-1.2.0"
    sha256 cellar: :any_skip_relocation, catalina:     "e765d983ab4514710d142698b9946a1d28c728e5d6d96f74dc9e4fb09924ed6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ecfdc14da95cf65023948ce4bf5b21aa6832e2a28106aa468befb50ae5c19628"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "dnsmasq"

  def install
    system "make", "all"
    bin.install "bin/dnsname"
  end

  test do
    system bin/"dnsname"
  end
end
