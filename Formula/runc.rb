class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  url "https://github.com/opencontainers/runc.git",
    tag: "v1.0.0-rc93"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/runc-1.0.0-rc92"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "52938d6847319fc6a1eb0242f150b33635bf249b8c0556c639c2f0950c9d807c"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "pkg-config" => :build

  conflicts_with "nicholasdille/tap/runc-bin", because: "both install `runc` binary"

  def install
    dir = buildpath/"src/github.com/opencontainers/runc"
    dir.install (buildpath/"").children
    cd dir do
      buildtags = [
        "seccomp",
      ]
      commit = Utils.git_short_head
      ENV["GOPATH"] = buildpath
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
        "-tags", "#{buildtags} netgo osusergo",
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
  end

  test do
    assert_match "runc version #{version}", shell_output("#{bin}/runc --version")
  end
end
