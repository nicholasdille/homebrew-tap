class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.5.0",
    revision: "757252063bf4724f11a52336ef13a724059a39b6"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.4.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "279d621679eca9a5ba83c32bcbea5bf5a2f10de520b7bdc8589f742dac1f5360"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ca0df6e676ecfa74e14847f61a8cc4c6068980787939a482a54a2e6468a99a23"
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
