class Trillian < Formula
  desc "Transparent, highly scalable and cryptographically verifiable data store"
  homepage "https://github.com/google/trillian"

  url "https://github.com/google/trillian.git",
    tag:      "v1.4.2",
    revision: "0501b8848a453ab661e05631eeaa2e22f420d7d3"
  license "Apache-2.0"
  head "https://github.com/google/trillian.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trillian-1.4.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "c188ee6c957b00e6d194d0228354c2c0a5c6fa00a5aa2e4a814dc14de2e4f27d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "324ae84c75fe033d4e19b81482316f6de6fb585e2818725924a87679defa0ba5"
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
