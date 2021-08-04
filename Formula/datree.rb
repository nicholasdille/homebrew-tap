class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.2.2",
    revision: "89c9a359aedd11e63943cb633a4f4cbabd0fc6e0"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.2.2"
    sha256 cellar: :any_skip_relocation, catalina:     "9a861eb7adb386f5c945770d8ea54a0913eeab8c7b408af4fda9d3e93d59d1e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2522157d51ec4af45ca6ec917f02f1a27b5e27207b48c5e07381eb55ce86fc50"
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
