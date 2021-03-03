class Oras < Formula
  desc "OCI Registry As Storage"
  homepage "https://github.com/deislabs/oras"

  url "https://github.com/deislabs/oras.git",
    tag:      "v0.10.0",
    revision: "173c010570c48e4aa18ce186cae8cc812f8e8b6e"
  license "MIT"
  head "https://github.com/deislabs/oras.git"

  depends_on "go" => :build

  def install
    pkg = "github.com/deislabs/oras"
    commit = Utils.safe_popen_read("git", "rev-parse", "HEAD")
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags",
      "-w"\
      " -X #{pkg}/internal/version.BuildMetadata=#{version}"\
      " -X #{pkg}/internal/version.GitCommit=#{commit}"\
      " -X #{pkg}/internal/version.GitTreeState=clean",
      "-o",
      "#{bin}/oras",
      "#{pkg}/cmd/oras"
  end

  test do
    system "#{bin}/task", "--version"
  end
end
