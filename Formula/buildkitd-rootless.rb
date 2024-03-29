class BuildkitdRootless < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "file:///dev/null"
  version "1.0.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "Apache-2.0"
  revision 1

  livecheck do
    skip "Manual version"
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildkitd-rootless-1.0.0_1"
    rebuild 2
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d2ffad929b42c657446bcc02e6ae1d9200248e6617eb8fc0d70c1010fe22b04c"
  end

  depends_on "immortal"
  depends_on "nicholasdille/tap/buildkitd"
  depends_on "nicholasdille/tap/fuse-overlayfs-bin"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    (buildpath/"buildkitd-rootless.sh").write <<~EOS
      #!/bin/bash

      #{HOMEBREW_PREFIX}/bin/rootlesskit --net=slirp4netns --copy-up=/etc --disable-host-loopback #{HOMEBREW_PREFIX}/bin/buildkitd
    EOS
    bin.install "buildkitd-rootless.sh"

    (buildpath/"buildkitd-rootless.yml").write <<~EOS
      cmd: #{bin}/buildkitd-rootless.sh
      env:
        XDG_RUNTIME_DIR: #{var}/run/buildkitd-rootless
      pid:
        parent: #{var}/run/buildkitd-rootless/parent.pid
        child: #{var}/run/buildkitd-rootless/child.pid
      log:
        file: #{var}/log/buildkitd-rootless.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    pkgshare.install "buildkitd-rootless.yml"
  end

  def post_install
    mkdir_p etc/"immortal"
    cp pkgshare/"buildkitd-rootless.yml", etc/"immortal"
    mkdir_p var/"run/buildkitd"
    mkdir_p var/"log"
  end

  def caveats
    <<~EOS
      - You can now run rootless buildkitd using immortal
      - To access buildkitd, set BUILDKIT_HOST to unix://#{var}/run/buildkitd/buildkit/buildkitd.sock
    EOS
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/buildkitd", "--version"
  end
end
