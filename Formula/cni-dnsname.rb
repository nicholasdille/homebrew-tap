class CniDnsname < Formula
  desc "Name resolution for containers"
  homepage "https://github.com/containers/dnsname"

  url "https://github.com/containers/dnsname.git",
    tag:      "v1.3.0",
    revision: "dc59f285546a0b0d8b8f20033e1637ea82587840"
  license "Apache-2.0"
  head "https://github.com/containers/dnsname.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

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
