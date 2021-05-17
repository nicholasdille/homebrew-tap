class Kim < Formula
  desc "In ur kubernetes, buildin ur imagez"
  homepage "https://github.com/rancher/kim"

  url "https://github.com/rancher/kim.git",
    tag:      "v0.1.0-alpha.12",
    revision: "ac0a8eb3d8801e0e8808b1d6d5303b70c2b3beb0"
  license "Apache-2.0"
  head "https://github.com/rancher/kim.git"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-alpha.12"
    sha256 cellar: :any_skip_relocation, catalina:     "3bf67a6703f132ff1de012ab2d8d18333f3c2251a0811a4ea619f56280ef3195"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d1aa1c19cf5771e3bfa8a03f224c99817922d48bf437a8a50b0df5feac722fb"
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
