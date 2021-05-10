class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org"

  url "https://github.com/opencontainers/runc.git",
    tag:      "v1.0.0-rc94",
    revision: "2c7861bc5e1b3e756392236553ec14a78a09f8bf"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/runc-1.0.0-rc93_3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d9aab214b95871bb817afcf45e0741dcbe26d96cf92c39b4a46d203a079b400f"
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
