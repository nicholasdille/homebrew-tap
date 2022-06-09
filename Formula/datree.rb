class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.7",
    revision: "d5856b015061e876a654d29749c2e0727f59c99c"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.7"
    sha256 cellar: :any_skip_relocation, big_sur:      "83def102ee8d1d13cabf56935d42269fcc4527f4e9a6df0c04d6597f309e0224"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f81f4f5612b79f4d838076434f7f4a2fe28af000cb5f6898f5a934263a28a190"
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
