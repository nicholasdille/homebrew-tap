class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.1.763",
    revision: "c602ff1f6b14d07cb66a88124e8b551c9f65c6cc"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.1.763"
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
