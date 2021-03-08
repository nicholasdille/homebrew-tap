class FirecrackerContainerd < Formula
  desc "Enables containerd to manage containers as Firecracker microVMs"
  homepage "https://github.com/firecracker-microvm/firecracker-containerd"

  url "https://github.com/firecracker-microvm/firecracker-containerd.git"
  version "master"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker-containerd.git"

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ENV["STATIC_AGENT"] = "on"
    extragoargs = "-ldflags '-s -w'"

    system "make", "-C", "agent", "EXTRAGOARGS=#{extragoargs}"
    bin.install "agent/agent"

    system "make", "-C", "runtime", "EXTRAGOARGS=#{extragoargs}"
    bin.install "runtime/containerd-shim-aws-firecracker"

    system "make", "-C", "firecracker-control/cmd/containerd", "EXTRAGOARGS=#{extragoargs}"
    bin.install "firecracker-control/cmd/containerd/firecracker-containerd"
    bin.install "firecracker-control/cmd/containerd/firecracker-ctr"
  end

  test do
    system "#{bin}/agent", "--help"
    system "#{bin}/containerd-shim-aws-firecracker", "--help"
    system "#{bin}/firecracker-containerd", "--version"
    system "#{bin}/firecracker-ctr", "--version"
  end
end
