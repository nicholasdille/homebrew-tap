class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org"

  url "https://github.com/opencontainers/runc.git",
    tag:      "v1.1.1",
    revision: "52de29d7e0f8c0899bd7efb8810dd07f0073fa87"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/runc-1.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3165a389f3e8b6877d0d5baf62e10e0b9c4b612359977e063d25e44dbc4e71e9"
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
