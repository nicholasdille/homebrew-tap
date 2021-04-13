class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.8.2",
    revision: "d4c0271775875d08d427f85a2ea5f472e3155910"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git"

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-devmapper", "Support device mapper"
  option "without-cri", "Support CRI"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "protobuf" => :build

  def install
    system "make", "build", "LDFLAGS=-w -s -X main.Version=v#{version}"
    bin.install "bin/localizer"
  end

  test do
    system bin/"localizer", "--version"
  end
end
