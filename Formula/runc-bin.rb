class RuncBin < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  license "Apache-2.0"

  if Hardware::CPU.intel?
    url "https://github.com/opencontainers/runc/releases/download/v1.0.0-rc92/runc.amd64"
    sha256 "256bd490a55a1939a4c9cd15c043404b79a86429ee04129c00d33dab8c0cf040"
  else
    odie "Only amd64 is supported"
  end

  bottle :unneeded

  conflicts_with "nicholasdille/tap/runc", because: "both install `runc` binary"

  def install
    bin.install "runc.amd64" => "runc"
  end

  test do
    system "#{bin}/runc", "--version"
  end
end
