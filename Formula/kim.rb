class Kim < Formula
  desc "In ur kubernetes, buildin ur imagez"
  homepage "https://github.com/rancher/kim"

  url "https://github.com/rancher/kim.git",
    tag:      "v0.1.0-beta.6",
    revision: "8733bde7b7a942d53c4885fcaace9903132eda8c"
  license "Apache-2.0"
  head "https://github.com/rancher/kim.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-beta.6"
    sha256 cellar: :any_skip_relocation, catalina:     "ac46d1bc47db93721166065661eff5d7d01b4fe5ef96a4f4ebfa12d29d58bb31"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f10cea79a2da8fb62f995e6faf8927c36ae248965a1654cc07c45e14c5383e5"
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
