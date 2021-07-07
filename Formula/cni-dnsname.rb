class CniDnsname < Formula
  desc "Name resolution for containers"
  homepage "https://github.com/containers/dnsname"

  url "https://github.com/containers/dnsname.git",
    tag:      "v1.2.0",
    revision: "3b29247c46d2811610ad57dd9fdae61157532a5b"
  license "Apache-2.0"
  head "https://github.com/containers/dnsname.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-dnsname-1.1.1"
    sha256 cellar: :any_skip_relocation, catalina:     "1ea5d2f41b1954b7440554bd9bd9c9a1f66afb95f84c4e2d5d473f17cfc0db41"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5a72bd07d4b7e5df8f3a5901b7686fe24a865c5bb6bbb09a701ded9806199e2c"
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
