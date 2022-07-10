class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.29",
    revision: "33ab23a2cafbc7c1ac45094466e9d52e32e5eed2"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.29"
    sha256 cellar: :any_skip_relocation, big_sur:      "8038e3419aabdea94e0917f5291fd3c90843f71e390ee1bc59cd6a4528353822"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0b13dd1ad7617839ddfc111650040d48fa2596ba08f3253602cc6f7949acecb8"
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
