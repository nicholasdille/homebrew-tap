class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.3",
    revision: "27e42181656d8a5c83ba32bb1aa015a7e5e63ac6"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "c3ec5a96aa99c4272c0c67dcea41de2c0374757620ecae3f90f0543a746209e7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1ad89249bd72f594f57589ad2cff26820796f8d8c5162f9cee7ed99a733af8f4"
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
