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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.6.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "df3cb39fd12041287d8744dcfa50275b9e0d14b6c93b517dc39b13d4c931e6a0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6ebfc0e94e9ce20c8d4c1ad02cb72530c8789c07623b7bc3f233fa5eaa7c1dcc"
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
