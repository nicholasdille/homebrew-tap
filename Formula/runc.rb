class Runc < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://www.opencontainers.org/"
  url "https://github.com/opencontainers/runc.git",
    tag: "v1.0.0-rc92"
  sha256 "2c76083d4460778d3532ee2d2a858602a2a38fd3f262ea52a4211cb6e2c2baa5"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runc.git"

  depends_on "pkg-config" => :build
  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/opencontainers/runc"
    dir.install (buildpath/"").children
    cd dir do
      buildtags = [
        "seccomp"
      ]
      commit = Utils.git_short_head
      ENV["CGO_ENABLED"] = "1"
      ldflags = [
        "-w",
        "-extldflags",
        "-static",
        "-X",
        "main.gitCommit=#{commit}",
        "-X",
        "main.version=#{version}"
      ]
      system "go", "build", "-trimpath", "-tags", "#{buildtags} netgo osusergo", "-ldflags", ldflags.join(" "), "-o", bin/"runc", "."
  
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
