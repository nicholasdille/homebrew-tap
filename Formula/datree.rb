class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.85",
    revision: "9c63844b7171489f475e5ad8432e3f20725a057d"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.85"
    sha256 cellar: :any_skip_relocation, big_sur:      "83ffa6a0e226b8e55c8d887dd7abc5f8634737080080954c1f871bc839dfaed7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bf1ab1a627a3170d44e4310fedbfeaeb9b59e88992679ff35b4cd43cdf0c4525"
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
