class KubectlBuild < Formula
  desc "Tool for building container images with your Kubernetes cluster"
  homepage "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl"

  url "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    tag:      "v0.1.4",
    revision: "3cdb0965332177c4f254ea81b96c9ce7b8c46d3d"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubectl-build-0.1.3"
    sha256 cellar: :any_skip_relocation, catalina:     "1cd1fea7f0c582df82e2f6c9d9b5414823b531c98451e67f1660b49c55840ce8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "decda61f63e1f7ec9c3af2a002702d3f737e57688d13dfb2507a9f80ff163e71"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "build"

    goos = "linux"
    goos = "darwin" if OS.mac?

    bin.install "bin/#{goos}/kubectl-buildkit"
    bin.install "bin/#{goos}/kubectl-build"
  end

  test do
    system "whereis", "kubectl-buildkit"
    system "whereis", "kubectl-build"
  end
end
