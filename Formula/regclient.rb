class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.3",
    revision: "61a71d4fb8fcb87f76f606095ca648e68eeeedfc"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.2"
    sha256 cellar: :any_skip_relocation, catalina:     "ddc7341f8981072daa30937a5c89fc46d0e322cc30383712d8403ca3c3c951a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "48adba226db3c37a91bccde9aeebf6dbbe14c54617db5169bc101e2808ac36d6"
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
