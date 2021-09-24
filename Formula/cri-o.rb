class CriO < Formula
  desc "OCI-based implementation of Kubernetes Container Runtime Interface"
  homepage "https://cri-o.io/"

  url "https://github.com/cri-o/cri-o.git",
    tag:      "v1.22.0",
    revision: "6becad23eadd7dfdd25fd8df386bf3b706cf7758"
  license "Apache-2.0"
  head "https://github.com/cri-o/cri-o.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cri-o-1.21.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7537ace7c45159e24299f93d1e93c8e660fc3d76cef118e1b9151dbc38c1b5db"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "with-devmapper", "Support device mapper"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "gpgme" => [:build, :recommended]
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux
  depends_on "libseccomp" => :recommended

  def install
    ENV.O0

    buildtags = ["containers_image_ostree_stub"]
    # buildtags << "apparmor" # libapparmor
    buildtags << "exclude_graphdriver_btrfs" if build.without? "btrfs"
    buildtags << "btrfs_noversion" if build.without? "btrfs"
    buildtags << "exclude_graphdriver_devicemapper" if build.without? "devmapper"
    buildtags << "libdm_no_deferred_remove" if build.without? "devmapper"
    buildtags << "containers_image_openpgp" if build.with? "gpgme"
    buildtags << "seccomp" if build.with? "libseccomp"
    # buildtags << "selinux" # selinux
    # buildtags << "libsubid" # shadow

    system "make", "bin/crio", "bin/crio-status", "bin/pinns", "BUILDTAGS=#{buildtags.join(",")}"
    bin.install "bin/crio"
    bin.install "bin/crio-status"
    bin.install "bin/pinns"

    system "make", "docs"
    man5.install Dir["docs/*.5"]
    man8.install Dir["docs/*.8"]

    # bash completion
    output = Utils.safe_popen_read("#{bin}/crio", "complete", "bash")
    (bash_completion/"crio").write output

    # fish completion
    output = Utils.safe_popen_read("#{bin}/crio", "complete", "fish")
    (zsh_completion/"crio.fish").write output

    # zsh completion
    output = Utils.safe_popen_read("#{bin}/crio", "complete", "zsh")
    (zsh_completion/"_crio").write output

    # bash completion
    output = Utils.safe_popen_read("#{bin}/crio-status", "complete", "bash")
    (bash_completion/"crio-status").write output

    # fish completion
    output = Utils.safe_popen_read("#{bin}/crio-status", "complete", "fish")
    (zsh_completion/"crio-status.fish").write output

    # zsh completion
    output = Utils.safe_popen_read("#{bin}/crio-status", "complete", "zsh")
    (zsh_completion/"_crio-status").write output

    # configuration
    output = Utils.safe_popen_read("#{bin}/crio", "--config-dir=", "--config=", "config")
    (buildpath/"crio.conf").write output
    etc.install "crio.conf"
  end

  test do
    system bin/"crio", "--version"
  end
end
