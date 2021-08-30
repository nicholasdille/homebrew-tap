class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v1.0.52-beta",
    revision: "798994850dd67f959cfd7b922f32d7d5dc6fbc48"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    system "go",
      "mod",
      "tidy"

    system "go",
      "build",
      "-o",
      bin/"kubescape",
      "."
  end

  test do
    system "whereis", "kubescape"
  end
end
