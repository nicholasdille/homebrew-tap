class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.1.22",
    revision: "f6662ea382bd17da51026bf5ade00e5e5464d5bf"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.1.22"
    sha256 cellar: :any_skip_relocation, big_sur:      "fbced9ab4760195825f7cec1343c884deee791909a14a5c68111007a934cd431"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fcfb2f074c04884c7603a7160285da2bc3b877039cdd53785f56108187a287d4"
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
