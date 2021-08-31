class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v1.0.55",
    revision: "f069955231fae552bd48409c233676439053b9a4"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-1.0.55"
    sha256 cellar: :any_skip_relocation, catalina:     "b62a0c0dc001ad815423a4f270aedc35f39fe32e9c02103f8c1fa9bd13a95776"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "04aa602f54584f6a29f9f43b3d583323c99bee2f57733d4b646a803cf6be29dc"
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
