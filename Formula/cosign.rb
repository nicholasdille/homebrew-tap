class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.3.0",
    revision: "a91aa202a01b830dafa969bb46f168e9c44580bd"
  license "Apache-2.0"
  revision 1
  head "https://github.com/sigstore/cosign.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git do |tags|
      tags.map { |tag| tag[/^v(\d+\.\d+\.\d+)$/i, 1] }.compact
    end
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.3.0_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "4e49efa0efde2498dd6367a03b7a0f91a30720281e2c2a75d0e66738bc94a784"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "26180e04cd3ad33275cbc89ab6e5126d7c188dc19564ab2959810cbc11c11269"
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
