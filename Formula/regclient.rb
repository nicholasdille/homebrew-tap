class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.4",
    revision: "b4184a0dfaedffad38ab14e28b9b32a7a96d9a29"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.4"
    sha256 cellar: :any_skip_relocation, catalina:     "cd265b96f90c9b61fec0ffeb11bb73e73f9d199411d3d012911c7586350a5492"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a5c798bbdb331f044db97fce1ac5d54806ae96a7d2138bd8554480cac94b6b68"
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
