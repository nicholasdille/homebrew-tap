class CniDnsname < Formula
  desc "Name resolution for containers"
  homepage "https://github.com/containers/dnsname"

  url "https://github.com/containers/dnsname.git",
    tag:      "v1.3.1",
    revision: "18822f9a4fb35d1349eb256f4cd2bfd372474d84"
  license "Apache-2.0"
  head "https://github.com/containers/dnsname.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-dnsname-1.3.1"
    sha256 cellar: :any_skip_relocation, catalina:     "6334b7199434a90d329db41054f92afd2ed0d3b26e3ae51589792655ea9cb34a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "76cfd8a5db337f31845e408c7b7cc53c60eb47d94a666d213e3bd3ba8a1d1602"
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
