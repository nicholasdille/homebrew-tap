class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.0",
    revision: "920d861490d2b669b6c4462cbcf7180374b61fda"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "4ddd338552680c9fc6e1eecbdcc7728e95dc6243a48ff5a180ff4c88ed4b9b20"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8d56efc1378b3628255ac685d5121c5a29981e8e46e5e098e83116179568ffd7"
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
