class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.30",
    revision: "36cebd57f351652cd6b1815980ca8980ce398cb7"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.30"
    sha256 cellar: :any_skip_relocation, big_sur:      "e0f02b2c9d9a3e882c20a68537b95cbaf6d149ae395b6ab85b9b138a19b1f1fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bbcf1c7e51792e1152d8d226b20d55cf5d7365f9f3417f7cb704100ccbd22064"
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
