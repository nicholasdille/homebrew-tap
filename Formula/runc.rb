class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org"

  url "https://github.com/opencontainers/runc.git",
    tag:      "v1.0.2",
    revision: "52b36a2dd837e8462de8e01458bf02cf9eea47dd"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git"

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
    commit = Utils.git_short_head

    buildtags = []
    buildtags << "seccomp" if build.with?("libseccomp")
    buildtags << "nokmem" if build.with?("nokmem")

    ENV["CGO_ENABLED"] = "1"
    ldflags = [
      "-w",
      "-extldflags",
      "-static",
      "-X",
      "main.gitCommit=#{commit}",
      "-X",
      "main.version=#{version}",
    ]
    system "go", "build",
      "-trimpath",
      "-mod=vendor",
      "-tags", "#{buildtags.join(" ")} netgo osusergo",
      "-ldflags", ldflags.join(" "),
      "-o", bin/"runc",
      "."

    Pathname.glob("man/*.[1-8].md") do |md|
      section = md.to_s[/\.(\d+)\.md\Z/, 1]
      (man/"man#{section}").mkpath
      system "go-md2man", "-in=#{md}", "-out=#{man/"man#{section}"/md.stem}"
    end

    bash_completion.install "contrib/completions/bash/runc"
  end

  test do
    system bin/"runc", "--version"
  end
end
