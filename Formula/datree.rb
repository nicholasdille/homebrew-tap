class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.2.0",
    revision: "a4f1890c4f418aacc5d8ec060b5c388b0a8573b9"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.2.0"
    sha256 cellar: :any_skip_relocation, catalina:     "7efa21273685fce6a0e7ba5668df86cab2e288fae517dafd91ae25b24953146f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "043d34e679944b01a0c3622714735191246385cea0a6c0a3d85c55167a619910"
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
