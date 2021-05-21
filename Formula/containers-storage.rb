class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.31.2",
    revision: "4adb7e18b1678595c72e1a0620728dc78065a8a4"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.31.1"
    sha256 cellar: :any_skip_relocation, catalina:     "eb6e5faf0ca418a403fe993805954bb7e4816b19d98e6b698cc8d1d0bd72d407"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "754d746e1c05dc4e15bbd487fd8aa4d3e1ff0ba915aacc3f881697a214ff323c"
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
