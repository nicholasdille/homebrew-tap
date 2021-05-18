class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.1.2",
    revision: "51b8ddbc22cf5b10dd76dd9243924aa66ad7db39"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containers/podman.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-3.1.2_1"
    sha256 cellar: :any_skip_relocation, catalina:     "ffa029d462e2e5b3f45ce659d2eeab9e05c23081552fb8d16f934456a140976d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e9bf20730ebe9f67030d64cf3e12d2881758812f88420e7154eb68a4f3a29115"
  end

  option "with-systemd", "Add support for systemd"
  option "with-selinux", "Add support for selinux"
  option "with-apparmor", "Add support for apparmor"
  option "with-btrfs", "Add support for btrfs"
  option "with-devicemapper", "Add support for devicemapper"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "gpgme" => :build
  depends_on "libseccomp" => [:build, :recommended]
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  def install
    on_linux do
      buildtags = []
      buildtags << "exclude_graphdriver_btrfs" if build.without? "btrfs"
      buildtags << "exclude_graphdriver_devicemapper" if build.without? "devicemapper"
      buildtags << "selinux" if build.with? "selinux"
      buildtags << "apparmor" if build.with? "apparmor"
      buildtags << "seccomp" if build.with? "libseccomp"
      buildtags << "systemd" if build.with? "systemd"

      system "make", "podman", "BUILDTAGS=#{buildtags.join(" ")}"
      bin.install "bin/podman"
    end

    system "make", "podman-remote-static"
    on_linux do
      bin.install "bin/podman-remote-static" => "podman-remote"
    end
    on_macos do
      bin.install "bin/podman-remote-static" => "podman"
    end

    system "make", "docs"
    man1.install Dir["docs/build/man/*.1"]

    bash_completion.install "completions/bash/podman"
    zsh_completion.install "completions/zsh/_podman"
  end

  test do
    assert_match "podman version #{version}", shell_output("#{bin}/podman -v")
  end
end
