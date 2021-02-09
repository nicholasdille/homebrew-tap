class RuncBin < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  if Hardware::CPU.intel?
    url "https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64"
    sha256 "9feaa82be15cb190cf0ed76fcb6d22841abd18088d275a47e894cd1e3a0ee4b6"
  else
    odie "Only amd64 is supported"
  end
  version "1.0.0-rc93"
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
