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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubectl-build-0.1.3"
    sha256 cellar: :any_skip_relocation, catalina:     "1cd1fea7f0c582df82e2f6c9d9b5414823b531c98451e67f1660b49c55840ce8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "decda61f63e1f7ec9c3af2a002702d3f737e57688d13dfb2507a9f80ff163e71"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "build"

    goos = "linux"
    on_macos do
      goos = "darwin"
    end

    bin.install "bin/#{goos}/kubectl-buildkit"
    bin.install "bin/#{goos}/kubectl-build"
  end

  test do
    system "whereis", "kubectl-buildkit"
    system "whereis", "kubectl-build"
  end
end
