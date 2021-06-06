class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.34.0",
    revision: "df5e906b0e3ef3ae51dde8f0248bb5108e8283c4"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.34.0"
    sha256 cellar: :any_skip_relocation, catalina:     "bf1649cefb1b84c3ee89e99c358e13ca5761d8d85c3fd951d05a36d654c78190"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "395456f8ffd0a4e595828547e93b36e3cf32992f5bd5bb8e318953f779630d4f"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", bin/"ytt",
      "./cmd/ytt"
  end

  test do
    system bin/"ytt", "--version"
  end
end
