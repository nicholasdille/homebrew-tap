class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://github.com/containers/buildah"

  url "https://github.com/containers/buildah.git",
    tag:      "v1.23.0",
    revision: "37fe4e86c284486c0ede084d579122c48ffe5dc1"
  license "Apache-2.0"
  head "https://github.com/containers/buildah.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildah-1.22.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "65f3774b366e9993ab7afd0494c705b45534727bc719a54c24d118c30c13ae6c"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on "nicholasdille/tap/docker" => :build
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
