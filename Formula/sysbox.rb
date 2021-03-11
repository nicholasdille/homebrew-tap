class SysboxGitDownloadStrategy < GitDownloadStrategy
  def update_submodules
    ohai "Fixing submodules in root"
    command! "sed",
      args:  ["-i", "-E", "s|git@github.com:|https://github.com/|", ".gitmodules"],
      chdir: cached_location
    command! "sed",
      args:  ["-i", "-E", "s|git@github.com:|https://github.com/|", ".git/config"],
      chdir: cached_location
    command! "git",
      args:  ["submodule", "update", "--init"],
      chdir: cached_location

    ohai "Fixing submodules in sysbox-fs"
    command! "sed",
      args:  ["-i", "-E", "s|git@github.com:|https://github.com/|", "sysbox-fs/.gitmodules"],
      chdir: cached_location
    command! "git",
      args:  ["submodule", "update", "--init"],
      chdir: cached_location/"sysbox-fs"

    ohai "Fixing submodules in sysbox-libs"
    command! "sed",
      args:  ["-i", "-E", "s|git@github.com:|https://github.com/|", "sysbox-libs/.gitmodules"],
      chdir: cached_location
    command! "git",
      args:  ["submodule", "update", "--init"],
      chdir: cached_location/"sysbox-libs"
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
