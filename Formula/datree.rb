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
    sha256 cellar: :any_skip_relocation, big_sur:      "a29ddc19eb651106171ca678964c08f7dff41c8d3d49528198d44883a9a1d2a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8cd93f0c719c7e06b406e43b30e59d127a363423fad205e072b0fe35ce10bf50"
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
