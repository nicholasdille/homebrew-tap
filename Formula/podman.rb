class Podman < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.4.2",
    revision: "2ad1fd3555de12de34e20898cc2ef901f08fe5ed"
  license "Apache-2.0"
  head "https://github.com/containers/podman.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-3.4.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a8efbf5aa1edaddeea66ff6f326247cb2885bf3d0e93d9e2db3df25727b569e4"
  end

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
  depends_on "nicholasdille/tap/cni"

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

      (buildpath/"containers.conf").write <<~EOS
        [network]
        cni_plugin_dirs = [ "/home/linuxbrew/.linuxbrew/bin" ]
      EOS
      (etc/"containers").install "containers.conf"
    end
  end

  def caveats
    <<~EOS
      This formula comes with a containers.conf located in #{etc}/containers.
      You can link or copy this file to \${HOME}/.config/containers or set the
      environment CONTAINERS_CONF:
      
          export CONTAINERS_CONF=#{etc}/containers/containers.conf
    EOS
  end

  test do
    assert_match "podman version #{version}", shell_output("#{bin}/podman -v")
  end
end
