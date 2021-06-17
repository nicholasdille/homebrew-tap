class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.2.0",
    revision: "f8449e8a350d31cf3b28e9a32b7e2521baf3a842"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0cd3a03e4196fe5106f5ef36fe39938b4c54e8f8bc54bd72f14fa15d585125f4"
  end

  depends_on "go" => :build
  depends_on "nicholasdille/tap/trillian"

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"rekor",
      "./cmd/cli"

    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"rekor-server",
      "./cmd/server"
  end

  test do
    system bin/"rekor", "--help"
    system bin/"rekor-server", "--help"
  end
end
