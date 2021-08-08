class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.4.0",
    revision: "a6ab848ca05fbb81b064899cc2445de84f276bb4"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "ea48dc662bd0971bcabd862ff45769c2a62cc69793c210b9844a4bae46f4f1d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "099989e6997595c54ec4eab6d8cec14a64d3ec763fca4bf37e5b33afb599ed96"
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
