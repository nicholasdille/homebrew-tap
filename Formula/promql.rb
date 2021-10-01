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

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/promql-0.2.1"
    sha256 cellar: :any_skip_relocation, catalina:     "821c83e0ac034fda100857d40ff1c119847c6fcca38b7c714e1af28dc74d225f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9ca7b80f314feaf7e1cc52001cb9d7dcc8693f75eafea150fd05c1594569f79b"
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
