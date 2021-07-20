class NpiperelayBin < Formula
  desc "Access Windows named pipes from WSL"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/jstarks/npiperelay/releases/download/v0.1.0/npiperelay_windows_amd64.zip"
  sha256 "6b9ef61ffd17c03507a9a3d54d815dceb3dae669ac67fc3bf4225d1e764ce5f6"
  license "MIT"
  head "https://github.com/jstarks/npiperelay.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle :unneeded

  depends_on :linux

  def install
    bin.install "npiperelay.exe"
  end

  test do
    system bin/"npiperelay.exe", "version"
  end
end
