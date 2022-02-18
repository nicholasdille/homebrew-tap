class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.5.2",
    revision: "8ffcd1228c463e1ad26ccce68ae16deeca2960b4"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.5.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "f25afc21540ce7ba17732e72e6d5a59b3b41e33b96c8719d38eb973b925182e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2a738d2f586895a627e57fa1b4b83e2e3c893c1e2d7ffe200ba8a29ac9f25b49"
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
