class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.13.4",
    revision: "76faac49cb8a8bfd80e0d853e9eed4503918475b"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.13.4"
    sha256 cellar: :any_skip_relocation, catalina:     "b3ddd604e4d490cd06b9955e5352f6d2c1aebd87d78008b3960dbf841ace3331"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dd10ab043050c313dfdc640cd84f1aca83a5f2870b69b20103999ea63fd9ebbc"
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
