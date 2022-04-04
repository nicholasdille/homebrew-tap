class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.7.0",
    revision: "7c271975d0bde39a51042a143c24c6a70ddf5633"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.7.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "a1362832f8aaeeb90624f34f72cff2991d3cb3d481a62d6cdecfdce99beea76f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8565c01c962f8d376b261c4a21b2bd5c0519953bb23d2a67aee1b5224b6243f1"
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
