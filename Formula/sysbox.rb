class SysboxGitDownloadStrategy < GitDownloadStrategy
  def update_submodules(timeout: nil)
    ohai "Adding rewrite for SSH based URLs"
    command! "git",
      args: [
        "config",
        "--global",
        "--add",
        "url.https://github.com/nestybox/.insteadOf",
        "git@github.com:nestybox/",
      ]
    
    super

    ohai "Removing rewrite for SSH based URLs"
    command! "git",
    args: [
      "config",
      "--global",
      "--unset-all",
      "url.https://github.com/nestybox/.insteadOf",
    ]
  end
end

class Sysbox < Formula
  desc "Enables containers to act as virtual servers"
  homepage "https://www.nestybox.com/"

  url "https://github.com/nestybox/sysbox.git",
    tag:      "v0.2.1",
    revision: "2ed540ae54e4f8fd9fff8655037de5edd38a4a56",
    using:    SysboxGitDownloadStrategy
  license "Apache-2.0"
  head "https://github.com/nestybox/sysbox.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sysbox-0.2.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bb752c6b26a2c30c7083897f4c281a3e84cf912b58dee85e6b7c0ab833af5db5"
  end

  depends_on "make" => :build

  def install
    system "make", "sysbox"
    system "make", "install", "INSTALL_DIR=#{bin}"
  end

  test do
    system bin/"sysbox-runc", "--version"
    system bin/"sysbox-mgr", "--version"
    system bin/"sysbox-fs", "--version"
  end
end
