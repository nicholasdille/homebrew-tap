class Promql < Formula
  desc "Prometheus Query CLI"
  homepage "https://github.com/nalbury/promql-cli"

  url "https://github.com/nalbury/promql-cli.git",
    tag:      "v0.2.1",
    revision: "b1dbc3474be3a2c37c5eff77f790a223459a134c"
  license "Apache-2.0"
  head "https://github.com/nalbury/promql-cli.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"promql",
      "."
  end

  test do
    assert_match "promql version v#{version}", shell_output("#{bin}/promql --version")
  end
end
