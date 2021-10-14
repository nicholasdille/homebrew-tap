class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.2",
    revision: "7db9ad0650693d0fe2ad2b3eed12857278b901c0"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.2"
    sha256 cellar: :any_skip_relocation, catalina:     "4f8bed68a41a7c17e74aad1107011cdd8b2b9e40ba6051c5429ac71b42b6c47c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cca293e8b4436bebc6df1139a053643dadb24adb1cd79b99de01accfe42d4ad8"
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
