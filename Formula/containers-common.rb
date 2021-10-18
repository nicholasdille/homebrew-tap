class ContainersCommon < Formula
  desc "Location for shared common files in github.com/containers repos"
  homepage "https://github.com/containers/common"

  url "https://github.com/containers/common.git",
    tag:      "v0.46.0",
    revision: "850904b0be9c4960a83acf077e34acc7857312bf"
  license "Apache-2.0"
  head "https://github.com/containers/common.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-common-0.46.0"
    sha256 cellar: :any_skip_relocation, catalina:     "0948757f460935555968d7d087aef436ea3b1fa7c3a0cacedd8ddb699184bb90"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "56adbb694d39b594f7363bc03f8b7f9812af445577bc411b1b7c1fd1570110d4"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "-C", "docs", "GOMD2MAN=go-md2man"
    man5.install Dir["docs/*.5"]

    (buildpath/"policy.json").write <<~EOS
      {
        "default": [
            {
                "type": "insecureAcceptAnything"
            }
        ]
      }
    EOS
    (etc/"containers").install "policy.json"

    (buildpath/"shortnames.conf").write <<~EOS
      [aliases]
        # centos
        "centos" = "registry.centos.org/centos"
        # containers
        "skopeo" = "quay.io/skopeo/stable"
        "buildah" = "quay.io/buildah/stable"
        "podman" = "quay.io/podman/stable"
        # docker
        "alpine" = "docker.io/library/alpine"
        "docker" = "docker.io/library/docker"
        "registry" = "docker.io/library/registry"
        "hello-world" = "docker.io/library/hello-world"
        "swarm" = "docker.io/library/swarm"
        # Fedora
        "fedora-minimal" = "registry.fedoraproject.org/fedora-minimal"
        "fedora" = "registry.fedoraproject.org/fedora"
        # openSUSE
        "opensuse/tumbleweed" = "registry.opensuse.org/opensuse/tumbleweed"
        "opensuse/leap" = "registry.opensuse.org/opensuse/leap"
        "opensuse/busybox" = "registry.opensuse.org/opensuse/busybox"
        "tumbleweed" = "registry.opensuse.org/opensuse/tumbleweed"
        "leap" = "registry.opensuse.org/opensuse/leap"
        "tw-busybox" = "registry.opensuse.org/opensuse/busybox"
        # SUSE
        "suse/sle15" = "registry.suse.com/suse/sle15"
        "suse/sles12sp5" = "registry.suse.com/suse/sles12sp5"
        "suse/sles12sp4" = "registry.suse.com/suse/sles12sp4"
        "suse/sles12sp3" = "registry.suse.com/suse/sles12sp3"
        "sle15" = "registry.suse.com/suse/sle15"
        "sles12sp5" = "registry.suse.com/suse/sles12sp5"
        "sles12sp4" = "registry.suse.com/suse/sles12sp4"
        "sles12sp3" = "registry.suse.com/suse/sles12sp3"
        # Red Hat Enterprise Linux
        "rhel" = "registry.access.redhat.com/rhel"
        "rhel6" = "registry.access.redhat.com/rhel6"
        "rhel7" = "registry.access.redhat.com/rhel7"
        "ubi7" = "registry.access.redhat.com/ubi7"
        "ubi7-init" = "registry.access.redhat.com/ubi7-init"
        "ubi7-minimal" = "registry.access.redhat.com/ubi7-minimal"
        "ubi8" = "registry.access.redhat.com/ubi8"
        "ubi8-minimal" = "registry.access.redhat.com/ubi8-minimal"
        "ubi8-init" = "registry.access.redhat.com/ubi8-init"
        # Debian
        "debian" = "docker.io/library/debian"
        # Ubuntu
        "ubuntu" = "docker.io/library/ubuntu"
    EOS
    (etc/"containers/registries.conf.d").install "shortnames.conf"
  end

  def caveats
    <<~EOS
      You should create symlinks for the configuration to take effect:

      mkdir -p $HOME/.config/containers
      ln -s #{etc}/containers $HOME/.config/containers

      sudo mkdir /etc/containers
      sudo ln -s #{etc}/containers /etc
    EOS
  end

  test do
    system "bash", "-c", "test -f #{etc}/containers/registries.conf.d/shortnames.conf"
  end
end
