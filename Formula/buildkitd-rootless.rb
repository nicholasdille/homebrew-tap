class BuildkitdRootless < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit.git",
    tag:      "v0.8.2",
    revision: "9065b18ba4633c75862befca8188de4338d9f94a"
  license "Apache-2.0"
  head "https://github.com/moby/buildkit.git"

  depends_on "immortal"
  depends_on "nicholasdille/tap/buildkitd"
  depends_on "nicholasdille/tap/fuse-overlayfs-bin"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    (buildpath/"buildkitd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/rootlesskit --net=slirp4netns --copy-up=/etc --disable-host-loopback #{HOMEBREW_PREFIX}/bin/buildkitd
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
    system "#{bin}/buildkitd", "--version"
  end
end
