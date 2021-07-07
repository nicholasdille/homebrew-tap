class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://github.com/containers/buildah"

  url "https://github.com/containers/buildah.git",
    tag:      "v1.21.2",
    revision: "af2a1d4d762a627e01a87f4aab4dd0c1876df6b6"
  license "Apache-2.0"
  head "https://github.com/containers/buildah.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildah-1.21.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a64d2e2b5ed4f46e97540e382fc79a06ca1775c8d0a39f8ed2414964dd91c576"
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
