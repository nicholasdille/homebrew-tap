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

  depends_on "make" => :build

  def install
    system "make", "sysbox"
    system "make", "install", "INSTALL_DIR=#{bin}"
  end

  test do
    system "sysbox-runc", "--version"
    system "sysbox-mgr", "--version"
    system "sysbox-fs", "--version"
  end
end
