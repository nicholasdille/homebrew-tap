class RuncBin < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  license "Apache-2.0"

  if Hardware::CPU.intel?
    url "https://github.com/opencontainers/runc/archive/v1.0.0-rc93.tar.gz"
    sha256 "e42456078d2f76c925cdd656e4f423b918525d8188521de05e893b6bb473a6f8"
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
