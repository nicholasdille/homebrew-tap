class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.10.0",
    revision: "3a6088d03d7c053f9b3bd61ed07fba92133579cf"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.9.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "8dedd13fe395a6ab83feb31b418c7a91a231fb2b7ecfac7006454b005beeb0b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d0d9da67814674db30c3e2d529612ad67805537a511590b525a55b6b0d435695"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make",
      "cosign",
      "policy-controller",
      "sget"
    bin.install "cosign"
    bin.install "policy-controller"
    bin.install "sget"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} version 2>&1")
  end
end
