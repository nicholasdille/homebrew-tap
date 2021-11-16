class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.49",
    revision: "0631a9bf54cc8d18102e81ac73629383203ca3c4"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.49"
    sha256 cellar: :any_skip_relocation, big_sur:      "73a0d7209d0e4c9160e93adba7228b0280e10154439c8646e83da929a321d36e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f9899afd7f09cfaad4373c72167aedd533a9e8e6b2888dabd28e9b9ff833cafe"
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
