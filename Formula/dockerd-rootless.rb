class DockerdRootless < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.5",
    revision: "363e9a88a11be517d9e8c65c998ff56f774eb4dc"
  license "Apache-2.0"
  head "https://github.com/moby/moby.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dockerd-rootless-20.10.5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4467b92c91d34df45ebf5990f0d7ea00ac63fd7c56ea6b7696ce2f885855b715"
  end

  depends_on "immortal"
  depends_on "nicholasdille/tap/dockerd"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    bin.install "contrib/dockerd-rootless.sh"

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
    system "#{HOMEBREW_PREFIX}/bin/dockerd", "--version"
  end
end
