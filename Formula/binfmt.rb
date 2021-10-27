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

  depends_on "go" => :build
  depends_on :linux

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", " -X main.revision=#{version}"\
                  " -X main.qemuVersion=#{version}",
      "-o", bin/"binfmt",
      "./cmd/binfmt"
  end

  test do
    system bin/"binfmt", "--version"
  end
end
