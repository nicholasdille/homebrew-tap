class DockerdRootless < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "file:///dev/null"
  version "1.0.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git"

  depends_on "immortal"
  depends_on "nicholasdille/tap/dockerd"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    (buildpath/"dockerd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/dockerd-rootless.sh --config-file #{etc}/docker/daemon.json
      cwd: #{etc}/docker
      env:
        XDG_RUNTIME_DIR: #{var}/run/dockerd
      pid:
        parent: #{var}/run/dockerd/parent.pid
        child: #{var}/run/dockerd/child.pid
      log:
        file: #{var}/log/dockerd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    (etc/"immortal").install "dockerd.yml"
  end

  def post_install
    (var/"run/dockerd").mkpath
    (var/"log").mkpath
  end

  def caveats
    <<~EOS
      TODO: brew immortal
    EOS
  end

  test do
    system "#{bin}/dockerd", "--version"
  end
end
