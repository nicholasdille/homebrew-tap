class CriO < Formula
  desc "OCI-based implementation of Kubernetes Container Runtime Interface"
  homepage "https://cri-o.io/"

  url "https://github.com/cri-o/cri-o.git",
    tag:      "v1.22.0",
    revision: "6becad23eadd7dfdd25fd8df386bf3b706cf7758"
  license "Apache-2.0"
  head "https://github.com/cri-o/cri-o.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cri-o-1.21.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7537ace7c45159e24299f93d1e93c8e660fc3d76cef118e1b9151dbc38c1b5db"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    # Build base from https://github.com/NixOS/docker
    image_name = "nix"
    system "docker",
      "build",
      "--tag", image_name,
      "github.com/NixOS/docker"

    # Create Dockerfile
    (buildpath/"Dockerfile").write <<~EOS
      FROM #{image_name}
      RUN apk update \
       && apk add \
              bash
    EOS

    # Build custom image
    system "docker",
      "build",
      "--tag", "#{image_name}-build",
      "."

    # Run build
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "#{image_name}-build",
      "nix", "build", "-f", "nix"
    # Fix permission
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "alpine",
      "chown", "-R", "#{Process.uid}:#{Process.gid}", "."
    # Move result
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "alpine",
      "cp", "-r", "result/bin", "."

    system "make", "install.bin-nobuild", "BINDIR=#{bin}"

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
    (etc/"crio.conf").write output
  end

  test do
    system bin/"crio", "--version"
  end
end
