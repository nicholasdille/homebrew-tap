class KubectlBuild < Formula
  desc "Tool for building container images with your Kubernetes cluster"
  homepage "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl"

  url "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    tag:      "v0.1.6",
    revision: "16bb60cb76b8c758f8f29907928d218ad9cd7483"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubectl-build-0.1.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "b4f1929462312108a69e3d3d5b714892c362d469f62d0f59251b164cc6997c79"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ca3ded9d7158572405ad9eadee8016c4a7a760836ae8ffaddfee31f9e0d918a5"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "build"

    os = "linux" if OS.linux?
    os = "darwin" if OS.mac?
    bin.install "bin/#{os}/kubectl-buildkit"
    bin.install "bin/#{os}/kubectl-build"
  end

  test do
    system "whereis", "kubectl-buildkit"
    system "whereis", "kubectl-build"
  end
end
