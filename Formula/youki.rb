class Youki < Formula
  desc "Container runtime written in Rust"
  homepage "https://github.com/containers/youki"

  url "https://github.com/containers/youki.git",
    tag:      "v0.0.2",
    revision: "0f662dd9794f54f42ec26ed569efd3ba016555b9"
  license "Apache-2.0"
  head "https://github.com/containers/youki.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # libdbus-glib-1-dev \
  # libelf-dev
  depends_on "dbus" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "systemd" => :build
  depends_on arch: :x86_64
  depends_on :linux

  def install
    system "./build.sh"
    bin.install "youki"
  end

  test do
    system bin/"youki", "-h"
  end
end
