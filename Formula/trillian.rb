class Trillian < Formula
  desc "Transparent, highly scalable and cryptographically verifiable data store"
  homepage "https://github.com/google/trillian"

  url "https://github.com/google/trillian.git",
    tag:      "v1.3.13",
    revision: "ec49beeb964961d6f88d09ff08c91726ba1df234"
  license "Apache-2.0"
  head "https://github.com/google/trillian.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trillian-1.3.13"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f7726186284966cc27582849c21f48a53db793a2f98ff2dc3d9d94e5e66510e0"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"trillian_log_server",
      "./cmd/trillian_log_server"

    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"trillian_log_signer",
      "./cmd/trillian_log_signer"
  end

  test do
    system bin/"trillian_log_server", "--help"
    system bin/"trillian_log_signer", "--help"
  end
end
