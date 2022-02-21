class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.21",
    revision: "356dfb25530476da63e17b854c5b518c57f9714e"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.21"
    sha256 cellar: :any_skip_relocation, big_sur:      "4e7351fbc2cc8f6a9fbfacf1bf8fb3ccce72ce854548c28a7903b99ac6dc8785"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b2ffb27c45c7a7e51c82f2948d754b4560d89d144a9a8ac2e8cfbbbb5075bc63"
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
