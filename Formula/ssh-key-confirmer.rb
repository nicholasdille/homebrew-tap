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

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ssh-key-confirmer-0.1"
    sha256 cellar: :any_skip_relocation, catalina:     "7034f4f26900608bbde6fdae63e4860012806389693a82532155b206e797b23e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d740fed57a41d1fd46b4e8e7ed42ae8da52a756aa9b741bbb41abf1493d13128"
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
