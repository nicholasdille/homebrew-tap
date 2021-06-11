class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.32.2",
    revision: "946fbb4904115e67c2ac9fb49b82665891d30c1e"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.32.1"
    sha256 cellar: :any_skip_relocation, catalina:     "5569290666a82bf7e720b6b0d780933aebc30057410a620ee7c9942d7ca61c1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6bca200005bb75f76ead36f71d715b02bafa1d5e89b811631fc179b218353e70"
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
