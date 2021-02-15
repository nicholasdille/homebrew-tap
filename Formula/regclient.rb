class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.2.1",
    revision: "4c6dd972a3c609f7c0997bb6e464aee431f8c971"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  depends_on "go" => :build

  def install
    system "make"
    bin.install "bin/regctl"
    bin.install "bin/regsync"
    bin.install "bin/regbot"
    bin.install "docker-plugin/docker-regclient"
  end

  test do
    system "#{bin}/regctl", "--help"
  end
end
