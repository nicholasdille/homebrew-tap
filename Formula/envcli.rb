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
