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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crictl-1.23.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "e731a0f691e854a564459f56faeba8498f370afa1614af5d9fda6e29fad3ce43"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "176fd5bd3fce7a531d67d13d1df52c0a57d7465aaecc62903a9973f2b6e44796"
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
