class Crictl < Formula
  desc "CLI and validation tools for Kubelet Container Runtime Interface"
  homepage "https://github.com/kubernetes-sigs/cri-tools"

  url "https://github.com/kubernetes-sigs/cri-tools.git",
    tag:      "v1.21.0",
    revision: "80bcedb1222865e848a4232a4bcf1a388b328ba9"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cri-tools.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crictl-1.21.0"
    sha256 cellar: :any_skip_relocation, catalina:     "cc28731829d15a1efc2f1489691625510e630be66d877705d6da5a00fb058016"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c2a6b14b9be78a0cd42b0da3f9f01cb8482dd88854289e4761e58bc825e049ee"
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
