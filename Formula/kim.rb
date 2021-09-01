class Kim < Formula
  desc "In ur kubernetes, buildin ur imagez"
  homepage "https://github.com/rancher/kim"

  url "https://github.com/rancher/kim.git",
    tag:      "v0.1.0-beta.5",
    revision: "23c49805524b837a8172936d80a1e173f939b633"
  license "Apache-2.0"
  head "https://github.com/rancher/kim.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-beta.5"
    sha256 cellar: :any_skip_relocation, catalina:     "6f6f1f3d05799bdaf4bc006dbe09bd00eef6631edffbc3a803df750992555fcb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6f3fac302b2cb6ebf2e52c4feebf1b86c8b153ffff5356df5136d1396da67f5f"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    dir = buildpath/"src/github.com/rancher/kim"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      system "make", "bin/kim"
      bin.install "bin/kim"
    end
  end

  test do
    system bin/"kim", "--version"
  end
end
