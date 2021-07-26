class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.33.0",
    revision: "04a2b1ecc58e64f7287ad2e8a58c25ee62b06983"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.32.6"
    sha256 cellar: :any_skip_relocation, catalina:     "4b47ec80976e153b22337634bec4de9f09f5687a0147c572286fffd6ff755b41"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "798b0997b26296849463da18427e19ac6a09525848ec13710fd9ab0bce9cb34c"
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
