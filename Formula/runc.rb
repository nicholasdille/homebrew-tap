class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org"

  url "https://github.com/opencontainers/runc.git",
    tag:      "v1.0.2",
    revision: "52b36a2dd837e8462de8e01458bf02cf9eea47dd"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/runc-1.0.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cb4b20ea4ee3fd0110275b9438d0977a4741e1cadc783f8d708b2b8a22d69009"
  end

  option "with-nokmem", "Disable kernel memory accounting"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => [:build, :recommended]
  depends_on "pkg-config" => :build
  depends_on :linux

  def install
    buildtags = []
    buildtags << "seccomp" if build.with?("libseccomp")
    buildtags << "nokmem" if build.with?("nokmem")

    ENV.O0
    system "make", "static", "BUILDTAGS=#{buildtags.join(" ")}"
    system "make", "install", "install-man", "install-bash", "DESTDIR=#{prefix}", "PREFIX="
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/runc --version")
  end
end
