class Crun < Formula
  desc "Fast and lightweight OCI runtime and C library for running containers"
  homepage "https://github.com/containers/crun"

  url "https://github.com/containers/crun.git",
    tag:      "0.20.1",
    revision: "38271d1c8d9641a2cdc70acfa3dcb6996d124b3d"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containers/crun.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crun-0.20.1"
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
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      image_name,
      "nix", "build", "-f", "nix/"
    # Move result
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "alpine",
      "cp", "-r", "result/bin", "."

    bin.install "crun"
  end

  test do
    system "#{bin}/crun", "--version"
  end
end
