class Mp3binder < Formula
  desc "Concatenating, joining, binding MP3 files without re-encoding"
  homepage "https://github.com/crra/mp3binder"

  url "https://github.com/crra/mp3binder.git",
    tag:      "4.0.0",
    revision: "f73a2b631c9bc08efeab0c5ae35bce1b28a89656"
  license "MIT"
  head "https://github.com/crra/mp3binder.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build
  depends_on "go-task/tap/go-task" => :build
  depends_on arch: :x86_64

  def install
    system "task", "build"
    bin.install "dist/linux_amd64/mp3binder"
  end

  test do
    system bin/"mp3binder", "--version"
  end
end
