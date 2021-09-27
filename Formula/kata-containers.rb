class KataContainers < Formula
  desc "Lightweight Virtual Machines (VMs) that feel and perform like containers"
  homepage "https://katacontainers.io/"

  url "https://github.com/kata-containers/kata-containers.git",
    tag:      "2.2.1",
    revision: "af0fbb94602a23501e2e8a17a5c98974ff0dc325"
  license "Apache-2.0"
  head "https://github.com/kata-containers/kata-containers.git"

  depends_on "gcc" => :build
  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "rust" => :build
  depends_on "yq" => :build
  depends_on :linux

  def install
    dir = buildpath/"src/github.com/kata-containers/kata-containers"
    (buildpath/"src").rename "src2"
    dir.install (buildpath/"").children
    (dir/"src2").rename dir/"src"
    cd dir/"src/runtime" do
      ENV["GOPATH"] = buildpath

      # https://github.com/kata-containers/kata-containers/blob/main/docs/Developer-Guide.md#build-and-install-the-kata-containers-runtime
      system "make", "PREFIX=#{prefix}"
      bin.install "kata-runtime"
      bin.install "kata-monitor"
      bin.install "kata-netmon"
      bin.install "containerd-shim-kata-v2"
      # configuration.toml
      bash_completion.install "src/runtime/data/completions/bash/kata-runtime"
    end
  end

  test do
    system "true"
  end
end
