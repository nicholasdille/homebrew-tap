class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.0.29",
    revision: "7e6de6678f6ed8a18661e1d5721b81ccee293b9b"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containers/conmon.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/conmon-2.0.29"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6e4907389b50abcade62fab262ba8b2a556ada32649569e943134f0020888c04"
  end

  depends_on "go-md2man" => :build
  depends_on :linux

  def install
    # Build base from https://github.com/NixOS/docker
    image_name = "nix"
    system "docker",
      "build",
      "--tag", image_name,
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
      "--tag", "#{image_name}-build",
      "."

    # Run build
    system "docker",
      "run",
      "--interactive",
      "--rm",
      "--mount", "type=bind,src=#{buildpath},dst=/src",
      "--workdir", "/src",
      "#{image_name}-build",
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
