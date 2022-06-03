class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.14.5",
    revision: "a0c0133066d367e56f925a021d8100436bf0cd8a"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.14.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "5ddff606c95cad4b215162dd21d31fa454105df3c9f95243d26d498ef5570016"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "80460c6de6dceeb194db8262282f2557f28d57aef1123eb239a7486bbf8f061a"
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
