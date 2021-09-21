class Trillian < Formula
  desc "Transparent, highly scalable and cryptographically verifiable data store"
  homepage "https://github.com/google/trillian"

  url "https://github.com/google/trillian.git",
    tag:      "v1.4.0",
    revision: "ac281dc7977d2a28952afb1f958917e15a1f04cf"
  license "Apache-2.0"
  head "https://github.com/google/trillian.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trillian-1.3.13_1"
    sha256 cellar: :any_skip_relocation, catalina:     "085fc370412a18275d5546b38fcb26ff7b369a15210f61ae9f2be840e1fe2016"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e5cec5036fb1c45c6d6411a356991e30f3f4ff9d6bd9ce747384386854d825b"
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
