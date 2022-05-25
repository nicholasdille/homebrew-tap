class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.30",
    revision: "8203b939a9d1f1bca87b4f1e6f384795746e8b63"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.30"
    sha256 cellar: :any_skip_relocation, big_sur:      "385f8c8592bec587232bd78c29631c2ff9774498b30d76f2e0138bc3c1af2363"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9236e0cefbfe3c61cfaf70971987400b44463833eb8a3e1f0fb6cd9d979116a0"
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
