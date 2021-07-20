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
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "e4308a8999d25e035f677637909e20bd1796c001dfc64a50f3775165fd910ae8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4d9f45b1add36e3235a7901ec7b29ce031cbe8984fa154a9931faca1f995c453"
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
