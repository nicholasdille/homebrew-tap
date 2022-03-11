class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.52",
    revision: "34815cb824e4ef8b205c322bbf7d727228898876"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.52"
    sha256 cellar: :any_skip_relocation, big_sur:      "205e5c3ad97f5d2c9699436b117f7e2137c7c4c466b42946db45444f7d56745a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "04074ff873c81d78e6d1699fa5276c95ccbc3306218ae37980b0bee4545a1361"
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
