class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.29",
    revision: "f66318b8531fd96ce1a61882803539652732db6b"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.29"
    sha256 cellar: :any_skip_relocation, big_sur:      "79f2e36f5e9d4cf955483269a63b182ebde3eef44f4b7bc8208aeefe8f1c6741"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f8516b4fd20b8900cc365ab2e8dbb90ba4a24606e4ad3648e41a219bb3fc83e8"
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
