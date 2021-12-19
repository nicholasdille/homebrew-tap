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
    sha256 cellar: :any_skip_relocation, big_sur:      "ab8e298905624aea67f5b23285e07ac1154058a5605baab9147bfc4f004c5a35"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "32c794382646b749fcbb01a6078a85959ce1dc01e17deb82a69b27da78cc4c76"
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
