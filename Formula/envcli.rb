class Envcli < Formula
  desc "Don't install Node, Go, ... locally - use containers"
  homepage "https://github.com/EnvCLI/EnvCLI"

  url "https://github.com/EnvCLI/EnvCLI.git",
    tag:      "v0.7.1",
    revision: "1afa7d446a3c8ece0c3df25e12b3779c86262360"
  license "MIT"
  head "https://github.com/EnvCLI/EnvCLI.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/envcli-0.7.1"
    sha256 cellar: :any_skip_relocation, catalina:     "fa0419662a9d477df5e29ea2a639bf2a568ea0562974828873f5be94e6dfd46e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2a7e8c1179445791eca64456394398741c11f06843d74a6bf4a400fbc5942ccc"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X main.Version=#{version}",
      "-o", bin/"envcli",
      "."
  end

  test do
    assert_match "EnvCLI version #{version}", shell_output("#{bin}/envcli --version")
  end
end
