class KubectlBuild < Formula
  desc "Tool for building container images with your Kubernetes cluster"
  homepage "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl"

  url "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    tag:      "v0.1.3",
    revision: "e76c756a93b2e6e02ea9ebc03a7bbcec7123c3a6"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubectl-build-0.1.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a8476347d0e119a59decb90d04178f2eac0828e9715615d2cc60b251d302e327"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "build"
    bin.install "bin/linux/kubectl-buildkit"
    bin.install "bin/linux/kubectl-build"
  end

  test do
    system "whereis", "kubectl-buildkit"
    system "whereis", "kubectl-build"
  end
end
