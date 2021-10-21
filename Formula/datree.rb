class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.6",
    revision: "5cdd238ea2cc91d346d4c5fe48d9570505b6738c"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "7acc1791d33b944c5358f68726d97bbdfc2f392543e0f87c9848f259b18a6b00"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "87427a35f6fe7f9b5911702879eb3fd93b87225637c64994d778245f5b2da5fe"
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
