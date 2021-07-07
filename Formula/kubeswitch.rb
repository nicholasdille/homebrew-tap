class Kubeswitch < Formula
  desc "Visually select kubernetes context/namespace from tree"
  homepage "https://github.com/danielb42/kubeswitch"

  url "https://github.com/danielb42/kubeswitch.git",
    tag:      "v1.4.0",
    revision: "5b63579c97c9f7cec9529ba66fcfd5c7754f2890"
  license "MIT"
  head "https://github.com/danielb42/kubeswitch.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeswitch-1.3.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bf9bdfdc3d842c0fca0db210be5da3508fb0a7f89141e2d529eb6d1f9d56e163"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = [
      "-w",
      "-extldflags",
      "-static",
    ]
    system "go", "build",
      "-tags", "netgo osusergo",
      "-ldflags", ldflags.join(" "),
      "-o", bin/"kubeswitch",
      "./cmd/..."
  end

  test do
    system "whereis", "kubeswitch"
  end
end
