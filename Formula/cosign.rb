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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.8.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7b8ebb2528ac5fab09fe9745db3790cd0a8984d3bc03ff0dbf8d1d276f3410c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5f4d0778b64a3d2f03eab4fc414019d2b429260ecd29c30cbf4a4439b34d5a34"
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
