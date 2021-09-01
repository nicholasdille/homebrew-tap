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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-beta.4"
    sha256 cellar: :any_skip_relocation, catalina:     "5a5482b6b942b80e82724bb19683a712030c639c9c528b25c74567dc3749a444"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "be4cfd461bdb71c7f9b052eec6d16c30e3a4ce33ba42db370e6b4cfd3372770e"
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
