class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.38.1",
    revision: "b3a0bf7bfd755a01e30bcef4edc3a27e5664ce7c"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.38.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "77715553d6a75da18790028407230ed316dbabc1eefe694527d18e66c74a8f0a"
  end

  option "with-btrfs", "Add support for btrfs"
  option "without-aufs", "Remove support auf aufs"
  option "without-vfs", "Remove support for vfs"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "device-mapper" => :optional

  def install
    dir = buildpath/"src/github.com/containers/storage"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      autotags = []
      autotags << "exclude_graphdriver_aufs" if build.without? "aufs"
      autotags << "exclude_graphdriver_btrfs" if build.without? "btrfs"
      autotags << "exclude_graphdriver_devicemapper" if build.without? "device-mapper"
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
