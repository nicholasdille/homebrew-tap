class Mp3binder < Formula
  desc "Concatenating, joining, binding MP3 files without re-encoding"
  homepage "https://github.com/crra/mp3binder"

  url "https://github.com/crra/mp3binder.git",
    tag:      "4.0.0",
    revision: "f73a2b631c9bc08efeab0c5ae35bce1b28a89656"
  license "Unlicense"
  head "https://github.com/crra/mp3binder.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/mp3binder-4.0.0_1"
    sha256 cellar: :any_skip_relocation, catalina:     "7490828fbbe5933b0f60613b2f92e14e832956b23a52406c4c5ddab8729222f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0de5687bec86b568e36f49efe22e1ccb5f55023ec9eb4767e57737cf9a1dd901"
  end

  depends_on "go" => :build
  depends_on arch: :x86_64

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "run",
      "cmd/build/build.go", "-p"

    os = "linux" if OS.linux?
    os = "darwin" if OS.mac?
    bin.install "dist/release/#{os}/mp3binder"
  end

  test do
    system bin/"mp3binder", "--version"
  end
end
