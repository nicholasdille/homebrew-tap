class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.5.1",
    revision: "c3e4d8b7cd2f6f065941510b260f173b70c695fa"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.5.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "beeccd08058efa8510ee139dd0cf51d73951084bb77650566ff93cee89f25e6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f1bfa4b076b0e1b91ca50538fe99eb8904d6aba0f5688a67f7285e8f79cb7c6e"
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
