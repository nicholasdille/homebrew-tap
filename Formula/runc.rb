class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org"

  url "https://github.com/opencontainers/runc.git",
    tag:      "v1.0.0-rc95",
    revision: "b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/runc-1.0.0-rc95"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "64064fecf7ee1f5bb585efaaaf0a06d6d1135c53c79f3f5a4588b7ded390754a"
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
