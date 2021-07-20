class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.10.0",
    revision: "c4b0e2f19384b441b624e2d2b286ee51fa5c304d"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.10.0"
    sha256 cellar: :any_skip_relocation, catalina:     "63838c7ed14b3d2b772fefb11a60f1dfc2f4b05a1643df0e46a1077242c4a290"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "23ce1ba9711831c2153feecc57a5d3aea168f2a7ee724cf03f5b95ebff7566fc"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-devmapper", "Support device mapper"
  option "without-cri", "Support CRI"

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
