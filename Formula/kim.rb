class Kim < Formula
  desc "In ur kubernetes, buildin ur imagez"
  homepage "https://github.com/rancher/kim"

  url "https://github.com/rancher/kim.git",
    tag:      "v0.1.0-alpha.11",
    revision: "dad9de2d3561e6d5aab3e31187a33047f5c37929"
  license "Apache-2.0"
  head "https://github.com/rancher/kim.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-alpha.11"
    sha256 cellar: :any_skip_relocation, catalina:     "6c0066672635d88617462078d031d6672afafb0811c6b373259ebf1a59f80835"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6441bfb58f52019205b50be2b07c3630ceba259acb4ccf7f12924ed4704110b"
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
