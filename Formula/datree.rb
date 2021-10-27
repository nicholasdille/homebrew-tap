class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.18",
    revision: "9988fe2506f6fc424d077644ac75656c294326cd"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.18"
    sha256 cellar: :any_skip_relocation, big_sur:      "9415bb71248a7d1a165514a96a4e97c5d0df9c1152959cc5ae883444f98e77cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "437fec5b707370d41a25b9008113a8d0f77152b800e0b60f9d0319584aa71f86"
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
