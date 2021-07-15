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
    tag:      "v0.4.0",
    revision: "63d8ee2f7acdb17d11921fa193dccb5b7b4207f8",
    using:    SysboxGitDownloadStrategy
  license "Apache-2.0"
  head "https://github.com/nestybox/sysbox.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sysbox-0.3.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a4979155eb986545e4639659498d5603631ef1e3e114cc18738a078fbb9eba16"
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
