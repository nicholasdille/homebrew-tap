class BuildkitdRootless < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "file:///dev/null"
  version "1.0.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "Apache-2.0"
  head "https://github.com/moby/buildkit.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildkitd-rootless-1.0.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "995f153f030d4b4117cbbddc4a59898a6527eb377804c7278853f883d1f7b86d"
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

    (buildpath/"buildkitd.yml").write <<~EOS
      cmd: buildkitd-rootless.sh
      env:
        XDG_RUNTIME_DIR: #{var}/run/buildkitd
      pid:
        parent: #{var}/run/buildkitd/parent.pid
        child: #{var}/run/buildkitd/child.pid
      log:
        file: #{var}/log/buildkitd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    (etc/"immortal").install "buildkitd.yml"
  end

  def post_install
    (var/"run/buildkitd").mkpath
    (var/"log").mkpath
  end

  def caveats
    <<~EOS
      TODO: brew immortal
      TODO: export BUILDKIT_HOST
    EOS
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/buildkitd", "--version"
  end
end
