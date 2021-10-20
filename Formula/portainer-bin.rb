class PortainerBin < Formula
  desc "Making Docker and Kubernetes management easy"
  homepage "https://www.portainer.io/"

  url "https://github.com/portainer/portainer/releases/download/2.9.1/portainer-2.9.1-linux-amd64.tar.gz"
  version "2.9.1"
  sha256 "927c0874c6ee9ac34055d530484757a276c25befe8cee5c18df1b15ee2cdefb2"
  license "Zlib"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :x86_64
  depends_on "kompose"
  depends_on "kubernetes-cli"
  depends_on :linux
  depends_on "nicholasdille/tap/docker"
  depends_on "nicholasdille/tap/docker-compose"
  depends_on "immortal" => :recommended

  def install
    bin.install "portainer"
    share.install "public"

    if build.with? "immortal"
      (buildpath/"portainer.yml").write <<~EOS
        cmd: #{bin}/portainer --assets=#{share} --data=#{HOMEBREW_PREFIX}/lib/portainer --no-analytics
        cwd: #{HOMEBREW_PREFIX}/lib/portainer
        pid:
          parent: #{var}/run/portainer/parent.pid
          child: #{var}/run/portainer/child.pid
        log:
          file: #{var}/log/portainer.log
          age: 86400
          num: 7
          size: 1
          timestamp: true
      EOS
      (etc/"immortal").install "portainer.yml"
    end
  end

  def post_install
    (var/"run/portainer").mkpath
    (var/"log").mkpath
    (HOMEBREW_PREFIX/"lib/portainer").mkpath
  end

  def caveats
    <<~EOS
      Start portainer manually:

        portainer --assets=#{share} --data=${HOME}/.portainer --no-analytics --host=unix:///var/run/docker.sock

      Start portainer using immortal:

        brew tap nicholasdille/immortal
        brew immortal list
        brew immortal start portainer
    EOS
  end

  test do
    system bin/"portainer", "--version"
  end
end
