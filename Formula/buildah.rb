class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://github.com/containers/buildah"

  url "https://github.com/containers/buildah.git",
    tag:      "v1.19.6",
    revision: "7aedb164287ed9c64ab38be2b3490782adadb894"
  license "Apache-2.0"
  head "https://github.com/containers/buildah.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildah-1.19.6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d991bf1bc5fdb978a63de532686e9274219cf14c9652ad59a48fe8e2cd2d2d6f"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build

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
    system "#{bin}/buildah", "--version"
  end
end
