class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.12.1",
    revision: "05df5eda92aa75b02883a5c9c2872bf2403e6423"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.12.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "124eb297ce4accedc6979e74e6fe0a9176b4362441f920818ff89b6e22922b39"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e11ae9e394ca31f3283283f3c153336c18cbb8a02ff913094a698186bd85d128"
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
