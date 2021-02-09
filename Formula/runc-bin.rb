class RuncBin < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  if Hardware::CPU.intel?
    url "https://github.com/opencontainers/runc/releases/download/v1.0.0-rc91/runc.amd64"
    sha256 "c1c30e250ba1af1bc513a37a85aef8c7824e9b8e76d10c933add58a72d84fce6"
  else
    odie "Only amd64 is supported"
  end
  version "1.0.0-rc91"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/runc", because: "both install `runc` binary"

  def install
    bin.install "runc.amd64" => "runc"
  end

  test do
    system "#{bin}/runc", "--version"
  end
end
