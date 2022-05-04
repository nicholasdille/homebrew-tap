class KataContainers < Formula
  desc "Lightweight Virtual Machines (VMs) that feel and perform like containers"
  homepage "https://katacontainers.io/"

  url "https://github.com/kata-containers/kata-containers.git",
    tag:      "2.4.1",
    revision: "67d67ab66dcd20e33d70e7e5241f1c26b24f66da"
  license "Apache-2.0"
  head "https://github.com/kata-containers/kata-containers.git",
    branch: "main"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kata-containers-2.4.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0846943b7c37e7842dc8804b4121bbf0ae72e78642b8c0c47b073408f072fd59"
  end

  depends_on "gcc" => :build
  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "rust" => :build
  depends_on "yq" => :build
  depends_on :linux

  def install
    ENV.O0

    dir = buildpath/"src/github.com/kata-containers/kata-containers"
    (buildpath/"src").rename "src2"
    dir.install (buildpath/"").children
    (dir/"src2").rename dir/"src"
    cd dir/"src/runtime" do
      ENV["GOPATH"] = buildpath

      system "make", "PREFIX=#{prefix}"
      bin.install "kata-runtime"
      bin.install "kata-monitor"
      bin.install "containerd-shim-kata-v2"

      bash_completion.install "data/completions/bash/kata-runtime"
    end
  end

  test do
    system "true"
  end
end
