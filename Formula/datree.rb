class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.17",
    revision: "74ce5010f333fc904a8d6bdf53a7d7fdff2ad54d"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.17"
    sha256 cellar: :any_skip_relocation, big_sur:      "d03d49af9b98f06d5257d2e5b0ea443c10b0536a0ba45151d30258cef8312991"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "662090a001588dc5499e9de6f1d5633bb288d71a7bb07a077dc8806d815db05d"
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
