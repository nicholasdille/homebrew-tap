class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.9.0",
    revision: "b80c73bb365e960897bd4451056fa855587af062"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.9.0"
    sha256 cellar: :any_skip_relocation, catalina:     "9fc1cc42c045d8bbc6bec747fd169cfb53eaea94e286774f3e36fe34322a5329"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "14aafe07122996ee7b5f09f4e8c158ad8d7b3dca2dd5883d45b1bc4f71e51111"
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
