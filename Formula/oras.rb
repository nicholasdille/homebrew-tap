class Oras < Formula
  desc "OCI Registry As Storage"
  homepage "https://github.com/deislabs/oras"

  url "https://github.com/deislabs/oras.git",
    tag:      "v0.11.0",
    revision: "ec34f5103ff1c00e83acb0e0160653bda4477a69"
  license "MIT"
  head "https://github.com/deislabs/oras.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/oras-0.11.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0fd571d31650e8820974da1a7fc82567b19442136cf33c6a2a8a6d01b008a579"
  end

  depends_on "git" => :build
  depends_on "go" => :build

  def install
    pkg = "github.com/deislabs/oras"
    commit = Utils.safe_popen_read("git", "rev-parse", "HEAD")
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-w -s"\
                  " -X #{pkg}/internal/version.BuildMetadata=#{version}"\
                  " -X #{pkg}/internal/version.GitCommit=#{commit}"\
                  " -X #{pkg}/internal/version.GitTreeState=clean",
      "-o", bin/"oras",
      "#{pkg}/cmd/oras"
  end

  test do
    system bin/"oras", "version"
  end
end
