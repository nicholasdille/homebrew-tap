class ContainersCommon < Formula
  desc "Location for shared common files in github.com/containers repos"
  homepage "https://github.com/containers/common"

  url "https://github.com/containers/common.git",
    tag:      "v0.43.0",
    revision: "ae1f43bc8b330da22b250ee9150de4e328562ac1"
  license "Apache-2.0"
  head "https://github.com/containers/common.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-common-0.42.1"
    sha256 cellar: :any_skip_relocation, catalina:     "a7b807adde9b082443443dfdbfa9396db23e74f3f0577b0096a80d625ae24824"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9118eb28058e7da379b349433767edc26d3eb0e088aa31e014fcc23ac0f068fb"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "-C", "docs", "GOMD2MAN=go-md2man"
    man5.install Dir["docs/*.5"]

    (etc/"containers/policy.json").write <<~EOS
      {
        "default": [
            {
                "type": "insecureAcceptAnything"
            }
        ]
      }
    EOS

    (etc/"containers/registries.conf.d/shortnames.conf").write <<~EOS
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
  end

  def caveats
    <<~EOS
      You should create a symlink:

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
