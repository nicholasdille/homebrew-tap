class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v1.0.56",
    revision: "d3f4af0f9c4f43cdbbe32222cf67fa71ca90a639"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-1.0.56"
    sha256 cellar: :any_skip_relocation, catalina:     "4c904dcc34f6e46c92f90e0d337570f3fc83541203d71408b0b9ee84657c68bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0ad2f848aab4cd50d0ca91b0f4c5071b34d844f216e3800eb0bcb92714ebf621"
  end

  depends_on "go" => :build

  def install
    system "go",
      "mod",
      "tidy"

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o",
      bin/"kubescape",
      "."
  end

  test do
    system "whereis", "kubescape"
  end
end
