class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.8",
    revision: "c0d4e8078e3e40d9854010a52e8353f98c8ae1ed"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.8"
    sha256 cellar: :any_skip_relocation, catalina:     "05e91f75eab41999a43d9421c5d0fca3b5b5b4ded1f13f2a7d9ce2ce469b6b9c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2b768fded65cbda7e08f558d05c519e8f14c381415567d9823e0393510f08af3"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make"
    bin.install "bin/regctl"
    bin.install "bin/regsync"
    bin.install "bin/regbot"
    bin.install "docker-plugin/docker-regclient"
  end

  test do
    system bin/"regctl", "version"
  end
end
