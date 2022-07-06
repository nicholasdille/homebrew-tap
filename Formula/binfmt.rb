class Binfmt < Formula
  desc "Cross-platform emulator collection distributed with Docker images"
  homepage "https://github.com/tonistiigi/binfmt"

  url "https://github.com/tonistiigi/binfmt.git",
    tag:      "deploy/v6.1.0-20",
    revision: "ee79c564456ab218708c09705ed8f4696c7ac5d5"
  license "MIT"
  head "https://github.com/tonistiigi/binfmt.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/binfmt-6.1.0-20"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c03a61f2d366944b2c3e59f82e4fcdcdc77724073976dbbef6f4daa6f1d09f5"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-X main.revision=#{version} " \
                  "-X main.qemuVersion=#{version}",
      "-o", bin/"binfmt",
      "./cmd/binfmt"
  end

  test do
    system bin/"binfmt", "--version"
  end
end
