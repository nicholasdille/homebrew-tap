class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.31.2",
    revision: "4adb7e18b1678595c72e1a0620728dc78065a8a4"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.31.2"
    sha256 cellar: :any_skip_relocation, catalina:     "fab00f50b57a15dc02f934e73ee62bde4490d557070e0cd67603d13f599a37d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c2bd742fb86cbc8fb1d7f19fcb89122bdc71da5494d9c5fc0b33627b6ceafea"
  end

  option "with-btrfs", "Add support for btrfs"
  option "with-devicemapper", "Add support for devicemapper"
  option "without-aufs", "Remove support auf aufs"
  option "without-vfs", "Remove support for vfs"

  depends_on "go" => :build
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
    end
  end

  test do
    system bin/"containers-storage", "--help"
  end
end
