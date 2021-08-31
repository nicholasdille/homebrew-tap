class Crictl < Formula
  desc "CLI and validation tools for Kubelet Container Runtime Interface"
  homepage "https://github.com/kubernetes-sigs/cri-tools"

  url "https://github.com/kubernetes-sigs/cri-tools.git",
    tag:      "v1.22.0",
    revision: "d82b602a7282356d4f675735a3ed4595fc7d73ce"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cri-tools.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crictl-1.22.0"
    sha256 cellar: :any_skip_relocation, catalina:     "cf03a3a4bba58e48c12a6e6e93bf768ffa81aba41c85f7d2a0e93a5787804a69"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4299dd1a5318acd62516d75d202922631352403f9057ca9aeabb25928fe25378"
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
