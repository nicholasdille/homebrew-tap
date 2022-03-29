class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.1.4",
    revision: "904f4be657cc355da4bffc853948d240a92d6732"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.1.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "d8e7069865a7c728189a3e46c7bd6bcbf08f99e28d6bd3b1c1ca2c44b8a18209"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1e68610557a3ea4abd0b7f01377dc20a72035796b3c69a915fdfac80c1f1465"
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
