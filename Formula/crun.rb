class Crun < Formula
  desc "Fast and lightweight OCI runtime and C library for running containers"
  homepage "https://github.com/containers/crun"

  url "https://github.com/containers/crun.git",
    tag:      "1.0",
    revision: "139dc6971e2f1d931af520188763e984d6cdfbf8"
  license "Apache-2.0"
  head "https://github.com/containers/crun.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crun-1.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6832567ae513cc165e327668953f9e3e0422a8c399e6231a635b2c8c2a4d3bf8"
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
