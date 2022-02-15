class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.14.2",
    revision: "aaa8eaf6d0961fe5aa400a4043c8d5a2602b7816"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.14.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "be17e4c4ea57e4ba1f3a26b35f7919ccc96dc1fa02d3ab3204f44be5654d70f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c4ffec5b0e05f43b0b93ff97a076744e6ab0ced59dafba60bd0b35eb5b7fc9cf"
  end

  depends_on "go" => :build
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
