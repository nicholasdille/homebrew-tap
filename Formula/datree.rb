class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.33",
    revision: "be2ba0672cf45820e35245e55c33e9394369b982"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.33"
    sha256 cellar: :any_skip_relocation, big_sur:      "f2b4f0da90bd3761d2f38768956407f81620209aa474ee58d771b6e8c42a574f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7ca1cafd5df15b474dbf92a7ab031571b07d5b0b58e4efb25857f1f6046b2b8c"
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
