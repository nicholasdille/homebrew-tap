class KubectlBuild < Formula
  desc "Tool for building container images with your Kubernetes cluster"
  homepage "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl"

  url "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    tag:      "v0.1.5",
    revision: "ca22e6ce3e5679eda12f044ee33eb5df7d2a4ec0"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubectl-build-0.1.4_1"
    sha256 cellar: :any_skip_relocation, catalina:     "99dacd18e431ce5887dcbc11b942ee6ed340dfe806fbecd0c3e8e89368828671"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a25f3895effcdebc4a04d665202cbb3d235001003b3b252828f0d5b76d5124bd"
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
