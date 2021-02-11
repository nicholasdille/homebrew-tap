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
    sha256 cellar: :any_skip_relocation, x86_64_linux: "15143f9b56505aee4e68b1e9e1de66185c07b14ed401e5ef837112ab6294fa6e"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "pkg-config" => :build

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
    system "#{bin}/runc", "--version"
  end
end
