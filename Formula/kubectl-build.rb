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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubectl-build-0.1.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "363b19e664474cb8f84ef9f2b83fb11c568b657844998f8a7ed645862d7c56f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "846c28a066835dbe161d2a0df02e40f272a3b85fc81f5e0fa33a8c80f825e76a"
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
