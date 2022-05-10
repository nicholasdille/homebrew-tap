class Trillian < Formula
  desc "Transparent, highly scalable and cryptographically verifiable data store"
  homepage "https://github.com/google/trillian"

  url "https://github.com/google/trillian.git",
    tag:      "v1.4.1",
    revision: "39951e750d9ae5bd45692867eb560fdc743fd52c"
  license "Apache-2.0"
  head "https://github.com/google/trillian.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trillian-1.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "5628acd2029fcdfc56243eb0ab3e8fb90e51f3900ee443e077f0d2956c0c84a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "432b2c716f9e1eca73a5cebc32688158c974977eb32f402cb7a9338648bc9894"
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
