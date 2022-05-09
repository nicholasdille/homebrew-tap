class PortainerBin < Formula
  desc "Making Docker and Kubernetes management easy"
  homepage "https://www.portainer.io/"

  url "https://github.com/portainer/portainer/releases/download/2.13.0/portainer-2.13.0-linux-amd64.tar.gz"
  version "2.13.0"
  sha256 "bb804521b03e25a44fc9e38ad3b337885993a9d566a708c0a2ae4d1871837071"
  license "Zlib"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/portainer-bin-2.13.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce8577b252ea7c2da12da7436080a0f07cdab68541d72a8027269e78b88ea976"
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
      pkgshare.install "portainer.yml"
    end
  end

  def post_install
    mkdir_p etc/"immortal"
    cp pkgshare/"portainer.yml", etc/"immortal"
    mkdir_p var/"run/portainer"
    mkdir_p var/"log"
    mkdir_p HOMEBREW_PREFIX/"lib/portainer"
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
