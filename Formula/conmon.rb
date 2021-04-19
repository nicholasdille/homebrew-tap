class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.0.27",
    revision: "65fad4bfcb250df0435ea668017e643e7f462155"
  license "Apache-2.0"
  head "https://github.com/containers/conmon.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/conmon-2.0.27"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c93f0c3bdf97ee5b1e953c986183ca4c487bf15d8d35b064e5b7ad9691002b21"
  end

  depends_on "go-md2man" => :build
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
      "--tag", "conmon",
      "."

    # Run build
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "conmon",
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

    bin.install "bin/conmon"

    system "make", "-C", "docs", "GOMD2MAN=go-md2man"
    man8.install Dir["docs/*.8"]
  end

  test do
    system "#{bin}/conmon", "--version"
  end
end
