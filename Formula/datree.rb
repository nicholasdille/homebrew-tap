class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.4.0",
    revision: "a6ab848ca05fbb81b064899cc2445de84f276bb4"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "a17eb54c2808dc8201d7902494503d2fc780bf47ff2baac190d8d5ddfdd501ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5559d59bffa9177cd025ebeb9e61a66ae5cc2d803a32fc15987215a76f9ee660"
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
