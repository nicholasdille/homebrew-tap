class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.0.27",
    revision: "65fad4bfcb250df0435ea668017e643e7f462155"
  license "Apache-2.0"
  head "https://github.com/containers/conmon.git"

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
    uid = Utils.safe_popen_read("id", "-u")
    gid = Utils.safe_popen_read("id", "-u")
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=$PWD,dst=/src",
      "--workdir", "/src",
      "alpine",
      "chown", "-R", "#{uid}:#{gid}", "."

    bin.install "bin/conmon"
  end

  test do
    system "#{bin}/conmon", "--version"
  end
end
