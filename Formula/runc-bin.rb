class RuncBin < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  if Hardware::CPU.intel?
    url "https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64"
    sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  else
    odie "Only amd64 is supported"
  end
  version "v1.0.0-rc93"
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
