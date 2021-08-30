class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.9.0",
    revision: "b80c73bb365e960897bd4451056fa855587af062"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.9.0"
    sha256 cellar: :any_skip_relocation, catalina:     "c2394587951b65663bd3dacd96c94987aceca33e1730ae9ca484fcf9cdc8567e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4d7c004fd5230704440c01f7f6dabe0ceb4d7d369208547ee3024ee493a19a88"
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
