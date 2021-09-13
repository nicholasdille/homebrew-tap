class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.13.0",
    revision: "c5e5f5198152903e302641576a111e8d21e44856"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.13.0"
    sha256 cellar: :any_skip_relocation, catalina:     "c7ed6cf6c3ac75ff2debc6a261c67c6b69d1d47a928c4aa6910effd8384c3e45"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b9f54019d72cc29d4a5af9d82953e401b34ce62b39fed8bcdcc8b4d6c94f2564"
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
