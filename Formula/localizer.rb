class Localizer < Formula
  desc "No-frills local development tool for service developers working in Kubernetes"
  homepage "https://blog.jaredallard.me/localizer-an-adventure-in-creating-a-reverse-tunnel-and-tunnel-manager-for-kubernetes/"

  url "https://github.com/getoutreach/localizer.git",
    tag:      "v1.9.0",
    revision: "1d3d97558d6b1d290c47b3e00f4beeef64634568"
  license "Apache-2.0"
  head "https://github.com/getoutreach/localizer.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/localizer-1.8.2"
    sha256 cellar: :any_skip_relocation, catalina:     "137642f41417ad7851bf0d3c4f704de498865fae830d0296870b75856d50a883"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "73e56b40059a801db15704b0383acc9838c529afb2ae83907edd56c0b5589d31"
  end

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
