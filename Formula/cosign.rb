class Cosign < Formula
  desc "Container Signing"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/cosign.git",
    revision: "f74fac540531411764589d72467ad6641e402971"
  version "0.0.0"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-0.0.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2e70353632bdfa57c08437ab58212f7e46aa413e1172a4689cf7e212bf5bf227"
  end

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
