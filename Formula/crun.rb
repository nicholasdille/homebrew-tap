class Crun < Formula
  desc "Fast and lightweight OCI runtime and C library for running containers"
  homepage "https://github.com/containers/crun"

  url "https://github.com/containers/crun.git",
    tag:      "0.21",
    revision: "c4c3cdf2ce408ed44a9e027c618473e6485c635b"
  license "Apache-2.0"
  head "https://github.com/containers/crun.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crun-0.21"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ebd6b942be8eb62592f17916ddca86603e9447810df06bee1e57dc5f1dddac3f"
  end

  depends_on :linux

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
