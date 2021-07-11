class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.5",
    revision: "40e713464d7aa2d043d93515fd5b09617ac183f2"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.5"
    sha256 cellar: :any_skip_relocation, catalina:     "a85c32602fcaf9ef2fba2c70d2597ff02ebc3934c2a769d09e1c46a0e35e181f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "74ed7d2ddef002e554eb30cce21e5eebaa3b55fcb3d25983aebe6d2edcb156a7"
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
