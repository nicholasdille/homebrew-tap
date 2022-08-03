class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.15.0",
    revision: "6a3a4965ca6b7dcccdd4f1c41cb100792fbbb704"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.14.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "43b3d81ff0cdc5106e9386fbcaad74e70cc55e28412f7f4a9c603b012624bf11"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3c107b07ea8078e481931ebc4d51b0ecf87822c91fd66b3a15724fc56cc9727a"
  end

  depends_on "go@1.17" => :build
  depends_on "protobuf" => :build

  def install
    ENV["GOPROXY"] = "https://proxy.golang.org"
    ENV["GOPRIVATE"] = "github.com/getoutreach/*"
    ENV["CGO_ENABLED"] = "1"

    system "go", "build",
      "-ldflags", "-w -s " \
                  "-X github.com/getoutreach/gobox/pkg/app.Version=#{version} " \
                  "-X github.com/getoutreach/go-outreach/v2/pkg/app.Version=#{version}",
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
