class Kubeswitch < Formula
  desc "Visually select kubernetes context/namespace from tree"
  homepage "https://github.com/danielb42/kubeswitch"

  url "https://github.com/danielb42/kubeswitch.git",
    tag:      "v1.4.0",
    revision: "5b63579c97c9f7cec9529ba66fcfd5c7754f2890"
  license "MIT"
  head "https://github.com/danielb42/kubeswitch.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeswitch-1.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "117c79a5a95b35d6714eaff125d4d2bd3e01c5e6d9279b61257e016ee92fe452"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0a0cc3791fc857c3a5c44881235193425694a34a037f816445b5a575e6b63c9a"
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
