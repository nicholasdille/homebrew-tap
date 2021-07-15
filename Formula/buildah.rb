class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://github.com/containers/buildah"

  url "https://github.com/containers/buildah.git",
    tag:      "v1.21.3",
    revision: "7f9540d2ab9037b7e175a4d1b36e85fc6541aeb5"
  license "Apache-2.0"
  head "https://github.com/containers/buildah.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildah-1.21.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "647928631ac8f837348b01297f22c5f2994abaa92f65810904f05fc4c9b8fd9f"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on :linux

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
      "--tag", "buildah",
      "."

    # Run build
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "buildah",
      "make", "static"

    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "alpine",
      "chown", "-R", "#{Process.uid}:#{Process.gid}", "."

    bin.install "bin/buildah"

    bash_completion.install "contrib/completions/bash/buildah"

    system "make", "-C", "docs", "GOMD2MAN=go-md2man"
    man1.install Dir["docs/*.1"]
  end

  test do
    system bin/"buildah", "--version"
  end
end
