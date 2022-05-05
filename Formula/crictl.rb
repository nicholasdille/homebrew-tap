class Crictl < Formula
  desc "CLI and validation tools for Kubelet Container Runtime Interface"
  homepage "https://github.com/kubernetes-sigs/cri-tools"

  url "https://github.com/kubernetes-sigs/cri-tools.git",
    tag:      "v1.24.0",
    revision: "f9710f792992ae7264d83cc894621174454d719c"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cri-tools.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crictl-1.24.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "9713e63ccaa66c9e1396828ce7d21ca3c9cccc4211acfbe48f0c3fc68be9bdf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dab77493db0042f4fed298fed100d0ec4c6eccf2e3636239f08c8bbf3e2b32af"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    dir = buildpath/"src/github.com/kubernetes-sigs/cri-tools"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      system "make", "binaries"
      bin.install "build/bin/crictl"
      bin.install "build/bin/critest"
    end
  end

  test do
    system bin/"crictl", "--version"
  end
end
