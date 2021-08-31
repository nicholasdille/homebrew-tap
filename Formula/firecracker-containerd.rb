class FirecrackerContainerd < Formula
  desc "Enables containerd to manage containers as Firecracker microVMs"
  homepage "https://github.com/firecracker-microvm/firecracker-containerd"

  url "https://github.com/firecracker-microvm/firecracker-containerd.git",
    revision: "435ade47c5462cbf2e7decdbf12a9570ae5b474a"
  version "0.0.0"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker-containerd.git",
    branch: "main"

  livecheck do
    skip "No tags or releases"
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-containerd-0.0.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a58131a7a9b665b099a55851a5d15631cfa58ee30bbfca557ed638bff3297d74"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux

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
