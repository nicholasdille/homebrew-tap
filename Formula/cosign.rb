class Cosign < Formula
  desc "Container Signing"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/cosign.git",
    tag:      "main",
    revision: "f74fac540531411764589d72467ad6641e402971"
  version "0.0.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"cosign",
      "./cmd"
  end

  test do
    system bin/"cosign", "--help"
  end
end
