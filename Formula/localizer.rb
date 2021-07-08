class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.10.0",
    revision: "c4b0e2f19384b441b624e2d2b286ee51fa5c304d"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.9.0"
    sha256 cellar: :any_skip_relocation, catalina:     "54ba0e2adb3117097d474c0ea803553041610d611ff59b822a3d36d75bb7cd56"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8997422530c6e345c2d273bbaf99708277086d3c2e4ad40d6f356fe5c222287"
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
