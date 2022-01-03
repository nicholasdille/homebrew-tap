class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.93",
    revision: "54dab659be2342d96b1de281f2f79b5825508bdc"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.93"
    sha256 cellar: :any_skip_relocation, big_sur:      "3cac7aabf218743957edcaf965a76985350aae6e26a7d90f213674d20b7ae285"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9584fa801b4242a3c672dd1da84bb2ce24101676aa312991001a888dfde80b25"
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
