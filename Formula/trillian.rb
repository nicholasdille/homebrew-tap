class Trillian < Formula
  desc "Transparent, highly scalable and cryptographically verifiable data store"
  homepage "https://github.com/google/trillian"

  url "https://github.com/google/trillian.git",
    tag:      "v1.3.13",
    revision: "ec49beeb964961d6f88d09ff08c91726ba1df234"
  license "Apache-2.0"
  head "https://github.com/google/trillian.git"

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
