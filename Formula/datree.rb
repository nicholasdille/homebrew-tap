class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.6.6",
    revision: "8cfc3a1d32de79810ad4dac6b50070a60766c40a"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.6.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "01dcb1b574a7ce97eba82ac36e0aefb9acf7cbf92685dd50e4c62fcde071db7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4336c7f25ce85985e0cd02663560c7585e801c8ab06df36b8a7ebc272cb4baab"
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
