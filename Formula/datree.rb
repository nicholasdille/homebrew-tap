class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.1.6",
    revision: "67f8d8db39232b6af358332fe3408f50467f740d"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.1.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "702d52d374cd55f01e3b5b39278c09bd1d88e0cc7c6ad58f9fa68e79e063aa90"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "257f6963ee9b25fb9c1dc5fc077296ef8f3a0b8712824e7eac08988480844097"
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
