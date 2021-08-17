class CniDnsname < Formula
  desc "Name resolution for containers"
  homepage "https://github.com/containers/dnsname"

  url "https://github.com/containers/dnsname.git",
    tag:      "v1.3.1",
    revision: "18822f9a4fb35d1349eb256f4cd2bfd372474d84"
  license "Apache-2.0"
  head "https://github.com/containers/dnsname.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-dnsname-1.3.0"
    sha256 cellar: :any_skip_relocation, catalina:     "21986a1f8ff1bc9528f613f73783a8ea4c1cd5b4d59657a5436be8ca1c0fbd3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "169840a5806c48a85fb780eb07a0d0b9367b4c08aa1dd9042244aa34f161064c"
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
