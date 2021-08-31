class Mp3binder < Formula
  desc "Concatenating, joining, binding MP3 files without re-encoding"
  homepage "https://github.com/crra/mp3binder"

  url "https://github.com/crra/mp3binder.git",
    tag:      "3.0.0",
    revision: "8eb964dbde9116f972e85f82e730d434b833eb3d"
  license "Unlicense"
  head "https://github.com/crra/mp3binder.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "run",
      "cmd/build/build.go", "-p"
    bin.install "dist/release/linux/mp3binder"
  end

  test do
    system bin/"mp3binder", "--version"
  end
end
