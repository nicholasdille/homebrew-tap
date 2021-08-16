class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.7.1",
    revision: "0b1e6cef6e916ac16dd0066686fd7f26e92f5982"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.7.1"
    sha256 cellar: :any_skip_relocation, catalina:     "4bfdd74768bfce114b8d0840d2dc554c8d715ea0b8368f86d2ecbce4969a7922"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0787b090919271f1446b1611a9ad6d91d648a6502c22c01beb6fc51507419205"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/datreeio/datree"
    ENV["CGO_ENABLED"] = "0"

    system "go", "build",
      "-tags", "main",
      "-ldflags", "-X #{pkg}/cmd.CliVersion=#{version}",
      "-o", bin/"datree",
      "./main.go"
  end

  test do
    system bin/"datree", "version"
  end
end
