class Slirp4netnsBin < Formula
  desc "User-mode networking for unprivileged network namespaces"
  homepage "https://github.com/rootless-containers/slirp4netns"
  license "GPL-2.0-only"

  if Hardware::CPU.intel?
    url "https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.8/slirp4netns-x86_64"
    sha256 "230a8df9857e83b0f68fa254ecb54a450ed2dbd6dadb54c2c9de890eaca5d68e"
  else
    odie "The following architectures has not been implemented yet: aarch64, armv7l, ppc64le, s390x."
  end
  version "1.1.8"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/slirp4netns"

  def install
    bin.install "slirp4netns-x86_64" => "slirp4netns"
  end

  test do
    system "#{bin}/slirp4netns", "--version"
  end
end
