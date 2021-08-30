class PodmanStatic < Formula
  desc "Tool for managing OCI containers and pods"
  homepage "https://podman.io/"

  url "https://github.com/containers/podman.git",
    tag:      "v3.3.0",
    revision: "98f252a3a1a8f1ee00f9f96c6ba00500954b5093"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containers/podman.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/podman-static-3.3.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b6b42f5b7b3cefcdf783e67a43d1eb0de68931cb18211c4de7f363784969b0bf"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/cni"
  depends_on "nicholasdille/tap/conmon"
  depends_on "nicholasdille/tap/containers-common"

  conflicts_with "podman"
  conflicts_with "nicholasdille/tap/podman-remote"
  # conflicts_with "nicholasdille/tap/podman"

  patch :DATA

  def install
    # Build base from https://github.com/NixOS/docker
    system "docker",
      "build",
      "--tag", "nix",
      "github.com/NixOS/docker"

    # Create Dockerfile
    (buildpath/"Dockerfile").write <<~EOS
      FROM nix
      RUN apk update \
       && apk add \
              bash \
              make \
              git \
              go
    EOS

    # Build custom image
    system "docker",
      "build",
      "--tag", "nix-build",
      "."

    # Run build
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "nix-build",
      "make", "static"

    # Fix permission
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "alpine",
      "chown", "-R", "#{Process.uid}:#{Process.gid}", "."

    bin.install "bin/podman"

    system "make", "docs", "GOMD2MAN=go-md2man"
    man1.install Dir["docs/build/man/*.1"]

    bash_completion.install "completions/bash/podman"
    zsh_completion.install "completions/zsh/_podman"
    fish_completion.install "completions/fish/podman.fish"
  end

  test do
    assert_match "podman version #{version}", shell_output("#{bin}/podman -v")
  end
end

__END__
diff --git a/libpod/network/config.go b/libpod/network/config.go
index 9a3bc4763..b4b94539e 100644
--- a/libpod/network/config.go
+++ b/libpod/network/config.go
@@ -12,7 +12,7 @@ import (
 
 const (
 	// CNIConfigDir is the path where CNI config files exist
-	CNIConfigDir = "/etc/cni/net.d"
+	CNIConfigDir = "/home/linuxbrew/.linuxbrew/etc/cni/net.d"
 	// CNIDeviceName is the default network device name and in
 	// reality should have an int appended to it (cni-podman4)
 	CNIDeviceName = "cni-podman"
