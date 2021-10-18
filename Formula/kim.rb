class Kim < Formula
  desc "In ur kubernetes, buildin ur imagez"
  homepage "https://github.com/rancher/kim"

  url "https://github.com/rancher/kim.git",
    tag:      "v0.1.0-beta.7",
    revision: "e597b9564b47213734787b3e0c540a635b250bbf"
  license "Apache-2.0"
  head "https://github.com/rancher/kim.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-beta.7"
    sha256 cellar: :any_skip_relocation, big_sur:      "350be01486aad8b0168dc1af0f892f3339695619ef9dcac5159ae008f54fb77b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "767ef40a570d551b0421b2f9635e866fdceb5a64cfcd53fb447d9211efbd3183"
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
