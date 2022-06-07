class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.3",
    revision: "27e42181656d8a5c83ba32bb1aa015a7e5e63ac6"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "e57460a514f4b2c829978d768a4b1b78648952af63c79a20f50e8a9c0640c9d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "878ac336d582d92e4d59be88be62279284fda4a43ca6917015918f8277ccc8a5"
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
