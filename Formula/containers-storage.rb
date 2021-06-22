class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.32.4",
    revision: "feb65b416570d23d8712c43009598fe70061ebdd"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.32.4"
    sha256 cellar: :any_skip_relocation, catalina:     "3b0690a63446b07bc3158b8f93bfcef35c71042b20bf8c7844711c56993642d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "166d511b1a69ab92b49c7f28850f7f33bc6ba759ce59c141264591fe873d78a0"
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
