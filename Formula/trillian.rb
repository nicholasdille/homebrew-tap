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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trillian-1.4.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "1dd495b5a01af95973a56d2a1c1542b69c3aa4a0eb204ea9dc5aa0bd4323cc19"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "693f57cdfc31ad9756963ff4ff182d7c06476488a44a7174765b0529c7a4b2f5"
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
