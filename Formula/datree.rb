class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.2.0",
    revision: "a4f1890c4f418aacc5d8ec060b5c388b0a8573b9"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.2.0"
    sha256 cellar: :any_skip_relocation, catalina:     "05c7b3600d860c13d0e8713ff0fcb937bf4bb83c1a4ca21c092475629143bd8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c52c237964b70929436c8848b706391beb4543bccc22b93812951a25b095ed90"
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
