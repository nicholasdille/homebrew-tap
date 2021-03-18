class Crun < Formula
  desc "Fast and lightweight OCI runtime and C library for running containers"
  homepage "https://github.com/containers/crun"

  url "https://github.com/containers/crun.git",
    tag:      "0.18",
    revision: "808420efe3dc2b44d6db9f1a3fac8361dde42a95"
  license "Apache-2.0"
  head "https://github.com/containers/crun.git"

  def install
    # Build base from https://github.com/NixOS/docker
    system "docker",
      "build",
      "--tag", "nix",
      "github.com/NixOS/docker"

    # Build custom image
    system "docker",
      "build",
      "--tag", "crun",
      "."

    # Run build
    system "docker",
      "run",
      "--interactive",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "nix",
      "nix", "build", "-f", "nix/"
    system "docker",
      "cp",
      "nix:/src/result/bin/crun",
      "."

    bin.install "crun"
  end

  test do
    system "#{bin}/crun", "--version"
  end
end
