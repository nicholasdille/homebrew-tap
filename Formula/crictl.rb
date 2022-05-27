class Crictl < Formula
  desc "CLI and validation tools for Kubelet Container Runtime Interface"
  homepage "https://github.com/kubernetes-sigs/cri-tools"

  url "https://github.com/kubernetes-sigs/cri-tools.git",
    tag:      "v1.24.2",
    revision: "d9642f137ca8d378782c6502fd345439bfb29777"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cri-tools.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crictl-1.24.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "2ef9374a6e1e95fbe490758be334f131870d5b3e36e4abef4ac9b41bb4b54b7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2b5d497e388d71a84fb8c065fbc5663c25d909bfbcddc789f6b4060c5f4c4aa6"
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
