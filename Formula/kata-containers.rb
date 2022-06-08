class KataContainers < Formula
  desc "Lightweight Virtual Machines (VMs) that feel and perform like containers"
  homepage "https://katacontainers.io/"

  url "https://github.com/kata-containers/kata-containers.git",
    tag:      "2.4.2",
    revision: "6d93875ead02f18396a2438b46148080549f50d1"
  license "Apache-2.0"
  head "https://github.com/kata-containers/kata-containers.git",
    branch: "main"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kata-containers-2.4.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1704c9d40e5a5a3e0afd4dea23414fd08b54ddefa80dc8dee4553ace8544eb5e"
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
