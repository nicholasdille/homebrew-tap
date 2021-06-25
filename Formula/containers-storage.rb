class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.32.5",
    revision: "e09b1b8ffab0c2af23c9a319b22531eab3efaa13"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.32.4_1"
    sha256 cellar: :any_skip_relocation, catalina:     "c32f36360842e4a4e97a052f85ca2c32042c9d33f351896d22c99de4ce7898ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dda727d90a2911db1cf7bd82b39f4354207a99628ca271c7f2c8e7a490f675f4"
  end

  option "with-btrfs", "Add support for btrfs"
  option "with-devicemapper", "Add support for devicemapper"
  option "without-aufs", "Remove support auf aufs"
  option "without-vfs", "Remove support for vfs"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  def install
    dir = buildpath/"src/github.com/containers/storage"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      autotags = []
      autotags << "exclude_graphdriver_aufs" if build.without? "aufs"
      autotags << "exclude_graphdriver_btrfs" if build.without? "btrfs"
      autotags << "exclude_graphdriver_devicemapper" if build.without? "devicemapper"
      autotags << "exclude_graphdriver_vfs" if build.without? "vfs"

      system "make", "binary", "AUTOTAGS=#{autotags.join(" ")}"
      bin.install "containers-storage"

      system "make", "-C", "docs", "GOMD2MAN=go-md2man"
      man5.install Dir["docs/*.5"]
    end
  end

  test do
    system bin/"containers-storage", "--help"
  end
end
