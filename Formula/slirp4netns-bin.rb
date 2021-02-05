class Slirp4netnsBin < Formula
  desc "User-mode networking for unprivileged network namespaces"
  homepage "https://github.com/rootless-containers/slirp4netns"
  if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.8/slirp4netns-x86_64"
    sha256 "230a8df9857e83b0f68fa254ecb54a450ed2dbd6dadb54c2c9de890eaca5d68e"
  elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.8/slirp4netns-aarch64"
    sha256 "aedd4b3d8f21c993b3681d77984b5bbc34ba3ae29c3d1920310e4cfa1678b8b8"
  elsif Hardware::CPU.ppc64le?
    url "https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.8/slirp4netns-ppc64le"
    sha256 "e49b47d1b5623a6d3b6d3d6a0471494f561a9b3ec966ecabd272f480dc517cbf"
  else
    odie "Processor architecture is not supported."
  end
  version "1.1.8"
  license "GPL-2.0-or-later"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/slirp4netns"

  def install
    bin.install "slirp4netns-x86_64" => "slirp4netns"
  end

  test do
    system "#{bin}/slirp4netns", "--version"
  end
end
