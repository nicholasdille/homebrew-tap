class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.14.4",
    revision: "7229dd540d2b80654ec5751aa9bb189d839919da"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.14.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "6c2a3bf84f9d31d62b47caa4ca3a546229c9cf224fe9e886eae8add026e1540d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "81e48a9ecb398eb87feddecd9e2521750abcee5ad01eb5911ee49fb134dc68cb"
  end

  depends_on "go@1.17" => :build
  depends_on "protobuf" => :build

  def install
    ENV["GOPROXY"] = "https://proxy.golang.org"
    ENV["GOPRIVATE"] = "github.com/getoutreach/*"
    ENV["CGO_ENABLED"] = "1"

    system "go", "build",
      "-ldflags", "-w -s"\
                  " -X github.com/getoutreach/gobox/pkg/app.Version=#{version}"\
                  " -X github.com/getoutreach/go-outreach/v2/pkg/app.Version=#{version}",
      "-v",
      "-tags=or_dev",
      "-o", buildpath,
      "github.com/getoutreach/localizer/..."
    bin.install "localizer"
  end

  test do
    system bin/"localizer", "--version"
  end
end
