class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org"

  url "https://github.com/opencontainers/runc.git",
    tag:      "v1.1.3",
    revision: "6724737f999df9ee0d8ca5c6d7b81f97adc34374"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/runc-1.1.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4bb479950e51b13bf0586d27919f3ad66cf87412c4943219d1c8c84b893e3d29"
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
