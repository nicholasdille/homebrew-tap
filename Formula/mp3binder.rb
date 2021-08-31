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

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/mp3binder-3.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "6725b69e64e5d9d57711480c5ea68a78fbd473a04aa353931e53c0bf8aa990f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "952794b63dcf3b382da730fd5c1f8d13f0415529291439ff70c02d47b8d9e703"
  end

  depends_on "go" => :build
  depends_on arch: :x86_64

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "run",
      "cmd/build/build.go", "-p"

    on_linux do
      bin.install "dist/release/linux/mp3binder"
    end
    on_macos do
      bin.install "dist/release/darwin/mp3binder"
    end
  end

  test do
    system bin/"mp3binder", "--version"
  end
end
