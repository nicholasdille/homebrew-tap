class Runq < Formula
  desc "Run regular Docker images in KVM/Qemu"
  homepage "https://containerd.io"

  url "https://github.com/gotoz/runq.git",
    revision: "09048dc5f51cb5935a03918a727d94c40d9deff4"
  version "0.0.0"
  license "Apache-2.0"
  head "https://github.com/gotoz/runq.git"

  depends_on "go" => :build
  depends_on "libseccomp" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux

  def install
    dir = buildpath/"src/github.com/gotoz/runq"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      ENV["CGO_CFLAGS"] = Utils.safe_popen_read("pkg-config", "--cflags", "libseccomp")
      ENV["CGO_LDFLAGS"] = Utils.safe_popen_read("pkg-config", "--libs", "libseccomp")

      ENV["RUNQ_ROOT"] = "/var/lib/runq"
      system "make", "all"
      (libexec/"qemu").install "cmd/proxy/proxy"
      libexec.install "cmd/runq/runq"
      libexec.install "cmd/runq-exec/runq-exec"
      (libexec/"qemu").install "cmd/runq-exec/mkcerts.sh"
      (libexec/"qemu").install "initrd/initrd"
    end
  end

  test do
    system bin/"runq", "--version"
  end
end
