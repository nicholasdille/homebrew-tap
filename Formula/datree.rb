class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.20",
    revision: "b1a5174136306fa4ee85d1dc2e0b723acb1f8369"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.20"
    sha256 cellar: :any_skip_relocation, big_sur:      "1a00f5da9d47d26d51b408e45982eb7e44860f12ac4a4b886dd8276dbf05ac4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bab506feb147e105c34e967bbd198e6b7b914b5820713c9e96045293634e7de2"
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
