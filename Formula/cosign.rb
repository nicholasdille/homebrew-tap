class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.6.0",
    revision: "4b2c3c0c8ee97f31b9dac3859b40e0a48b8648ee"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git do |tags|
      tags.map { |tag| tag[/^v(\d+\.\d+\.\d+)$/i, 1] }.compact
    end
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.6.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "573d9081380b930ad9e6078c299483ba47425c3bc9e7e64dfb30342033672c3e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ba85224bef372b1eb96c2baea89fef0117ab587c4a3726a04c8e33129573998b"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make",
      "cosign",
      "cosigned",
      "sget"
    bin.install "cosign"
    bin.install "cosigned"
    bin.install "sget"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} version 2>&1")
  end
end
