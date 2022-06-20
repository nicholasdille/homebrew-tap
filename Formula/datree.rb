class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.16",
    revision: "db614a3b7f2d20bd57fa4fa948e4cc7be11a351f"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.16"
    sha256 cellar: :any_skip_relocation, big_sur:      "b3e771c56f2b3ea34427ea0d844bde4bea7efe2f57e97e47f37e1ba16a1faf50"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c829f6b1197dfdde69f502e384ce04e059c8bfc30d6dc22750984b991baa7768"
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
