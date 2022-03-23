class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.0.15",
    revision: "bd179f47acdc8b52abbd281e6a05da1b54c76e9e"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.0.15"
    sha256 cellar: :any_skip_relocation, big_sur:      "cb54e783dd619ff27615c1f320509f45482ab4e22ff6ab66d2cce5f4266c4376"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "174746921ef4bc6b3446d30970d316f9283691daf3cdf849736f745117ae859f"
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
