class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.35.0",
    revision: "baee5051afae938b64aa9135e40dbdb844402c2e"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.35.0"
    sha256 cellar: :any_skip_relocation, catalina:     "cf7ac8f24059d79223458a5c6e5c9366e0b21681a048f8be542268a14bff20b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2f447ebbe01f1519e86fb4bb14b79b03bb35f1823190c49a677e731b51b8f4ba"
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
