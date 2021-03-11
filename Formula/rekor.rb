class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.1.1",
    revision: "3c6ce1678a9b4e02e98be671fe901490d071fcb8"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"rekor",
      "./cmd/cli"
  end

  test do
    system bin/"rekor", "--help"
  end
end
