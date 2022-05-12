class Crictl < Formula
  desc "CLI and validation tools for Kubelet Container Runtime Interface"
  homepage "https://github.com/kubernetes-sigs/cri-tools"

  url "https://github.com/kubernetes-sigs/cri-tools.git",
    tag:      "v1.24.1",
    revision: "d1d0120c55730038c65fa6baf98418b199f4b919"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cri-tools.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crictl-1.24.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "c95307933ad56b41f8e1c657af26935a50c5eb7a5c8bae1ef33680831c90184f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0fe13731fc6daa088fe5c8d8d453d786fa0a1582e3a35b87bcaafc252d96c6c0"
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
