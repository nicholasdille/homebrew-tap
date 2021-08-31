class Oras < Formula
  desc "OCI Registry As Storage"
  homepage "https://oras.land/"

  url "https://github.com/oras-project/oras.git",
    tag:      "v0.12.0",
    revision: "1e6a64e1789f5145bf669b75bebfe013100f6253"
  license "MIT"
  head "https://github.com/oras-project/oras.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/oras-0.12.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ed26beac0f116b3e84d0a4b448aa541d11a1be353ff74870e7fc6cc3fc3bae48"
  end

  depends_on "go" => :build

  conflicts_with "oras"

  def install
    pkg = "github.com/oras-project/oras"
    commit = Utils.git_short_head
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-w -s"\
                  " -X #{pkg}/internal/version.Version=#{version}"\
                  " -X #{pkg}/internal/version.BuildMetadata=Homebrew"\
                  " -X #{pkg}/internal/version.GitCommit=#{commit}"\
                  " -X #{pkg}/internal/version.GitTreeState=clean",
      "-o", bin/"oras",
      "./cmd/oras"
  end

  test do
    assert_match "#{version}+Homebrew", shell_output("#{bin}/oras version")
  end
end
