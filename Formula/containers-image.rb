class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.14.0",
    revision: "c02cf27d7fe541b84818bab0cd57cb458d46d496"
  license "Apache-2.0"
  head "https://github.com/containers/image.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.14.0"
    sha256 cellar: :any_skip_relocation, catalina:     "d18be44bc6b4e3137393d1bcada057e2564c70a57511dde333a796a28468b82e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d39e637fe9d8f90641559ec49b5d96eb856f6f5ff665a97da835b7faee9704b5"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "docs"
    man5.install Dir["docs/*.5"]
  end

  test do
    system "true"
  end
end
