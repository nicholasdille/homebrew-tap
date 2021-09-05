class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.12.0",
    revision: "6eab9620aad48582fd2a03eceef93d54e17a8a3d"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.12.0"
    sha256 cellar: :any_skip_relocation, catalina:     "8ee5b221553efe9a9d78ae66384c4f2df14c635b712cf91d698f81b7a7afa6ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d7a488611d1d63bb91e0573c7f78d90a8874b51bbbc551eb4e7fe1f3d47f51ab"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/datreeio/datree"
    ENV["CGO_ENABLED"] = "0"

    system "go", "build",
      "-tags", "main",
      "-ldflags", "-X #{pkg}/cmd.CliVersion=#{version}",
      "-o", bin/"datree",
      "./main.go"
  end

  test do
    system bin/"datree", "version"
  end
end
