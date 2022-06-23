class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.17",
    revision: "74ce5010f333fc904a8d6bdf53a7d7fdff2ad54d"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.17"
    sha256 cellar: :any_skip_relocation, big_sur:      "6008ae081c4f12b0ae06a9d1539b73273d143590ae8ae26b2b521480e914cc63"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6601612e35eb76e661ddd1d12f2fd752b0908641c80d8205f32f8a628e7344dc"
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
