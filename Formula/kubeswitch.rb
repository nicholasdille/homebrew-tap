class Kubeswitch < Formula
  desc "Visually select kubernetes context/namespace from tree"
  homepage "https://github.com/danielb42/kubeswitch"

  url "https://github.com/danielb42/kubeswitch.git",
    tag:      "v1.3.2",
    revision: "80cdbf56dc29ba003cb011846e028a4ef2a729e0"
  license "MIT"
  head "https://github.com/danielb42/kubeswitch.git"

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
      "-o", "kubeswitch",
      "./cmd/..."
    bin.install "kubeswitch"
  end

  test do
    system "#{bin}/kubeswitch", "foo"
  end
end
