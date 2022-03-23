class ContainersStorage < Formula
  desc "Methods for storing filesystem layers, container images, and containers"
  homepage "https://github.com/containers/storage"

  url "https://github.com/containers/storage.git",
    tag:      "v1.39.0",
    revision: "6345f74fafae7ea97d34db48b429570a058d9d41"
  license "Apache-2.0"
  head "https://github.com/containers/storage.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-storage-1.39.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b1be9e80d2134bc3c0755f0942cb395efccebb247124480b76052d8cd9a1b54b"
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
