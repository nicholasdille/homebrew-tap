class Nydus < Formula
  desc "Dragonfly image service for fast, secure and easy access to container images"
  homepage "https://github.com/dragonflyoss/image-service"

  url "https://github.com/dragonflyoss/image-service.git",
    tag:      "v1.0.0",
    revision: "5caf58755f5161e291230024343506584c8b4823"
  license "Apache-2.0"
  head "https://github.com/dragonflyoss/image-service.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "openssl" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on arch: :x86_64
  depends_on :linux

  def install
    system "make", "release", "nydusify", "nydus-snapshotter", "ctr-remote"
    system "make", "all-static-release"
    bin.install "target-fusedev/x86_64-unknown-linux-musl/release/nydusd"
    bin.install "target-fusedev/x86_64-unknown-linux-musl/release/nydus-image"
    bin.install "contrib/nydusify/cmd/nydusify"
    bin.install "contrib/nydus-snapshotter/bin/containerd-nydus-grpc"
    # bin.install "contrib/ctr-remote/bin/ctr-remote"
  end

  test do
    system bin/"nydusd", "--version"
  end
end
