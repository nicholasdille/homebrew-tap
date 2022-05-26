class Kubeswitch < Formula
  desc "Visually select kubernetes context/namespace from tree"
  homepage "https://github.com/danielb42/kubeswitch"

  url "https://github.com/danielb42/kubeswitch.git",
    tag:      "v1.5.0",
    revision: "49301a78da68560880520bc0d7538f5997d6d2a4"
  license "MIT"
  head "https://github.com/danielb42/kubeswitch.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeswitch-1.5.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "2c20222191a22267f977939ef5315716e009803226bebbb8a831c4f5901bb999"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f1a161a350b4350776a02cb2905385a7fc0219f4786688b8a2d566847f22edad"
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
