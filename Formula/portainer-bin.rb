class PortainerBin < Formula
  desc "Making Docker and Kubernetes management easy"
  homepage "https://www.portainer.io/"

  url "https://github.com/portainer/portainer/releases/download/2.14.2/portainer-2.14.2-linux-amd64.tar.gz"
  version "2.14.2"
  sha256 "b4e6675e8ca409326d4fe72862b7a0c3420681eec3cb03a6dddc83c7875df393"
  license "Zlib"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/portainer-bin-2.14.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8e1751410193acaeead322153521a8d2da15d1c07948b947e700dc5aa58c7f68"
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
