class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.13.2",
    revision: "87675586d2cd7e988dbda7133d15bd78d0519154"
  license "Apache-2.0"
  head "https://github.com/containers/image.git"

  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "docs"
    man5.install Dir["docs/*.5"]
  end

  test do
    system bin/"containers-storage", "--help"
  end
end
