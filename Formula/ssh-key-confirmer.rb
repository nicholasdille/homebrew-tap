class SshKeyConfirmer < Formula
  desc "Test ssh login key acceptance without having the private key"
  homepage "https://github.com/benjojo/ssh-key-confirmer"

  url "https://github.com/benjojo/ssh-key-confirmer.git",
    tag:      "v0.1",
    revision: "4eec893f72f4e694372b4ff701945587094c5f81"
  license "MIT"
  head "https://github.com/benjojo/ssh-key-confirmer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o",
      bin/"ssh-key-confirmer",
      "."
  end

  test do
    system bin/"ssh-key-confirmer", "--help"
  end
end
