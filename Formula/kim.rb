class Kim < Formula
  desc "In ur kubernetes, buildin ur imagez"
  homepage "https://github.com/rancher/kim"

  url "https://github.com/rancher/kim.git",
    tag:      "v0.1.0-beta.3",
    revision: "cd4c925206794dad6923a653ebc6a4e062ebdd75"
  license "Apache-2.0"
  head "https://github.com/rancher/kim.git"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-beta.2"
    sha256 cellar: :any_skip_relocation, catalina:     "679893675ae83719c77daf2d5427366d669d85942811f713511fe2a24dd48f1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "453963df4a83a6afa1246648e6e03e76b6fd08583ccf8ac382977a2f3c1ea031"
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
