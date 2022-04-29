class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.8.0",
    revision: "9ef6b207218572b3257a5b4251418d75569baaae"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "7ddd2ad83ba6e0cb26aa5d9bcfd8be3125e41dd819c94bf9e7f9b45b715c553c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "41f562468c14be68cca37d6742a894cc97c8eac0ea0738bebe4367f8c3ec4856"
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
