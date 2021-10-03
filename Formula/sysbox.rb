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
    tag:      "v0.4.1",
    revision: "977085f9a6db1d1b6172c09a5912b8c4b36cfd03",
    using:    SysboxGitDownloadStrategy
  license "Apache-2.0"
  head "https://github.com/nestybox/sysbox.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sysbox-0.4.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "906af0541f38a2e3ba46f1b8674f3ec1b129ab89e932b7321fc4734925fdf109"
  end

  depends_on "make" => :build
  depends_on :linux

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
