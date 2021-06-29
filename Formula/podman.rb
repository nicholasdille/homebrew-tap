class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.1.2",
    revision: "51b8ddbc22cf5b10dd76dd9243924aa66ad7db39"
  license "Apache-2.0"
  revision 2
  head "https://github.com/containers/podman.git"

  option "with-systemd", "Add support for systemd"
  option "with-selinux", "Add support for selinux"
  option "with-apparmor", "Add support for apparmor"
  option "with-btrfs", "Add support for btrfs"
  option "with-devicemapper", "Add support for devicemapper"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "gpgme"
  depends_on "libassuan"
  depends_on "libgpg-error"
  depends_on :linux
  depends_on "libseccomp" => :recommended

  def install
    dir = buildpath/"src/github.com/containers/podman"
    dir.install (buildpath/"").children
    cd dir do
      ENV.O0
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      buildtags = []
      buildtags << "exclude_graphdriver_btrfs" if build.without? "btrfs"
      buildtags << "exclude_graphdriver_devicemapper" if build.without? "devicemapper"
      buildtags << "selinux" if build.with? "selinux"
      buildtags << "apparmor" if build.with? "apparmor"
      buildtags << "seccomp" if build.with? "libseccomp"
      buildtags << "systemd" if build.with? "systemd"

      system "make", "podman", "BUILDTAGS=#{buildtags.join(" ")}"
      bin.install "bin/podman"

      system "make", "docs"
      man1.install Dir["docs/build/man/*.1"]

      bash_completion.install "completions/bash/podman"
      zsh_completion.install "completions/zsh/_podman"
    end
  end

  test do
    assert_match "podman version #{version}", shell_output("#{bin}/podman -v")
  end
end
