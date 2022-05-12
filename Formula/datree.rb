class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.13",
    revision: "223156eac99fbaed963cc69206b518e51dde998c"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.13"
    sha256 cellar: :any_skip_relocation, big_sur:      "79ebc5545497a69377d7ac41b59c176ada02594f187a5d8dd35662eae75d015d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "728e8d9056ba44aa40fe098e3f3c19f5006769e57b62b187feea70e03757964f"
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
