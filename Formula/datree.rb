class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.17",
    revision: "d27afba27bdc50b30e8725265a3908e664e5d078"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.17"
    sha256 cellar: :any_skip_relocation, big_sur:      "14eac7a114c31e8432be1a26af86ec1551bafb333435393edf177384f1faeb03"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5240d59d7a5dff1d52f41bf03f31db6b5faeb7a09654164575d9348b7fa5bc2d"
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
