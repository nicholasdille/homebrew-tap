class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.3.1",
    revision: "645ebf09fc555762a0494baa30edc08c38435368"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.3.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "1ccd0f9eab2dae0d1d049574418f946e580bad22058c4116b4c1c6ad0b89d30b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7fd7fda00b4cd5543db8b10fa11a49a533bdbfb588fbf2b9225c8d819c9a7f0c"
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
