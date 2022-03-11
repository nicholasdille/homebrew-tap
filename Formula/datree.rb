class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.52",
    revision: "34815cb824e4ef8b205c322bbf7d727228898876"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.52"
    sha256 cellar: :any_skip_relocation, big_sur:      "bb5236d1612621d0f75686b812e1d2e4291fe36b12d25733f32c253937c4eb88"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "24a5ef8f3da6b9f054ca2eb11c13935863024277bce2f6eeee531d785138746c"
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
