class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org"

  url "https://github.com/opencontainers/runc.git",
    tag:      "v1.0.0-rc93",
    revision: "12644e614e25b05da6fd08a38ffa0cfe1903fdec"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/runc-1.0.0-rc93"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78d9d1e617a2b7767bf89853b9d831bfaa3a2b9d25b44a545f6950475c008c6f"
  end

  option "with-nokmem", "Disable kernel memory accounting"
  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => [:build, :recommended]
  depends_on "pkg-config" => :build

  def install
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
      "-tags", "#{buildtags} netgo osusergo",
      "-ldflags", ldflags.join(" "),
      "-o", "runc",
      "."
    bin.install "runc"

    Pathname.glob("man/*.[1-8].md") do |md|
      section = md.to_s[/\.(\d+)\.md\Z/, 1]
      (man/"man#{section}").mkpath
      system "go-md2man", "-in=#{md}", "-out=#{man/"man#{section}"/md.stem}"
    end

    bash_completion.install "contrib/completions/bash/runc"
  end

  test do
    system "#{bin}/runc", "--version"
  end
end
