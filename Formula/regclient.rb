class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.7",
    revision: "9fa89f91fc311ba87e5f962ddc3192c4b57d3518"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.7"
    sha256 cellar: :any_skip_relocation, catalina:     "20129e6e632748224069008bc4422da1b616b079307266abce683737f73e1051"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b1a98134a9d9eaed233ca22c34c630d392ecf7de99141247bee33b5d2149553a"
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
