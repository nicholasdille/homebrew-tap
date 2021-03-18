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
    image_name = "nix"
    system "docker",
      "build",
      "--tag", image_name,
      "github.com/NixOS/docker"

    # Run build
    container_name = "crun"
    system "docker",
      "run",
      "--name", container_name,
      "--interactive",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      image_name,
      "nix", "build", "-f", "nix/"
    system "docker",
      "cp",
      "#{container_name}:/src/result/bin/crun",
      "."
    system "docker",
      "rm",
      container_name

    bin.install "crun"
  end

  test do
    system "#{bin}/crun", "--version"
  end
end
