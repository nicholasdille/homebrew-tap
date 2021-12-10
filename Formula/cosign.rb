class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.4.1",
    revision: "934567a4c606cf59e6ab17af889b4db3ee0a3f0b"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "fdee2e2987cdb0b1ace388b53899d465ae80526d1a88f60a58cda7a79a0ae14b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "37218fe3a0817e5327d1160e7e7aeec0518202d200e4f5c0dabcfa28a79e8194"
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
    assert_match version.to_s, shell_output("#{bin}/#{name} version")
  end
end
