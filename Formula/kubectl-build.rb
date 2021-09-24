class KubectlBuild < Formula
  desc "Tool for building container images with your Kubernetes cluster"
  homepage "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl"

  url "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    tag:      "v0.1.4",
    revision: "3cdb0965332177c4f254ea81b96c9ce7b8c46d3d"
  license "Apache-2.0"
  revision 1
  head "https://github.com/vmware-tanzu/buildkit-cli-for-kubectl.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubectl-build-0.1.4"
    sha256 cellar: :any_skip_relocation, catalina:     "bb304808274be690f8edd00a96801d2f98191b1e88d82a4695a1dfa6f59788f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "93ac3cefce922202b46a22ef26324164e9d10b4ae501e3de29692f854ea66784"
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
