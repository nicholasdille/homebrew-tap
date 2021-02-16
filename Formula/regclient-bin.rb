class RegclientBin < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient/releases/download/v0.2.1/regctl-linux-amd64"
  version "0.2.1"
  sha256 "82f3b2bc1edf3e27ff177eec7bb15a48c95d4cbab12844d41e7cb6da861dd333"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/regclient"

  resource "regsync" do
    url "https://github.com/regclient/regclient/releases/download/v0.2.1/regsync-linux-amd64"
    sha256 "18fa2f3cc439297685ed69fd6c7506843bdbd960a176451efe7f4765e0130626"
  end
  resource "regbot" do
    url "https://github.com/regclient/regclient/releases/download/v0.2.1/regbot-linux-amd64"
    sha256 "3670c90861647c1074bfb593cd264e20d47377a68ca22beeaec2fe1ee5f1a15b"
  end
  resource "docker-plugin" do
    url "https://github.com/regclient/regclient/raw/v0.2.1/docker-plugin/docker-regclient"
    sha256 "e04c8fc0d634d20cda6185f425a214d1c5246e94566311d7bc6caff03accb302"
  end

  def install
    bin.install "regctl-linux-amd64" => "regctl"
    resource("regsync").stage do
      bin.install "regsync-linux-amd64" => "regsync"
    end
    resource("regbot").stage do
      bin.install "regbot-linux-amd64" => "regbot"
    end
    resource("docker-plugin").stage do
      bin.install "docker-regclient"
    end
  end

  test do
    system "#{bin}/regctl", "--help"
  end
end
