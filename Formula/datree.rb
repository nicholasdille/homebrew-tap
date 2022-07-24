class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.6.0",
    revision: "700da85a6542b6945b9617f77b64dbf148129ded"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.6.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "2d036cecae628847e3d9804cc1facdfaad8193bf25606017ba0560efe0576046"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c915aecbde1f6368a3fc91d39741b5a591b3db2e7ed1037e321ab59487a999e7"
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
