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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.3.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "fb3311db9ea841a4681984fae4e50cb6d52b97766b913716ee1f825fa5d01a48"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ecc046f65e21de0e137cf134823a48e5614691f27a59cbae838bb8ea9fc5f8ff"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make",
      "cosign",
      "cosign-pivkey",
      "cosign-pkcs11key",
      "cosigned",
      "sget"
    bin.install "cosign"
    bin.install "cosign-pivkey"
    bin.install "cosign-pkcs11key"
    bin.install "cosigned"
    bin.install "sget"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} version")
  end
end
