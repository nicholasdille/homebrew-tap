class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.20",
    revision: "f1f0e61f75d633b64a0018da410d106de87cec79"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.20"
    sha256 cellar: :any_skip_relocation, big_sur:      "f7976be56c03227f759320f6a5e7df5d5b5436a912aa59a599c437a81402404c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "72eee1ebeb411b676802af18f3312d26d05ab564147333515e2d95059fcb17fd"
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
