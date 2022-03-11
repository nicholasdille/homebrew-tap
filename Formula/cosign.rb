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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.5.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "377d796f24d6e165817746bb7012843fe84432619ed4971919d1cbbee292b504"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "094c4da5507720c2f58fa3fd923d7bab69902def12bff729901c3c24192847a5"
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
