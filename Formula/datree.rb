class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.36",
    revision: "4b4932182a300df39687421789bd2d1844a874df"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.36"
    sha256 cellar: :any_skip_relocation, big_sur:      "962e851bf264011581eb829c3eb5c45af472f7172bd6dfd8f3dc0556a6801d8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a6fb43dd5315901ae95dd16167f14f1fb29b6c1f2b962bdc3213b343d0d212a2"
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
