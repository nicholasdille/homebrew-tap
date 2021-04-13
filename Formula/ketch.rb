class Ketch < Formula
  desc "Application delivery framework"
  homepage "https://github.com/shipa-corp/ketch"

  url "https://github.com/shipa-corp/ketch.git",
    tag:      "v0.2.1",
    revision: "bfb585fcc7a0518db1000cf40d885489d3e59e51"
  license "Apache-2.0"
  head "https://github.com/shipa-corp/ketch.git"

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "ketch"
    bin.install "bin/ketch"
  end

  test do
    system bin/"ketch", "--version"
  end
end
