class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.37",
    revision: "96dc5175a48bdba1cbe00fa03d1814a9c5be9f7e"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.37"
    sha256 cellar: :any_skip_relocation, big_sur:      "788384fc87bab460484eb56e7253d025df15eb0b72cdf6466b5eb85760e3f593"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "796d369665fa18e572e015e4418b138e6d5d661e2541aff3ffe67bcbdde370fe"
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
