class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.12.0",
    revision: "6eab9620aad48582fd2a03eceef93d54e17a8a3d"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.12.0"
    sha256 cellar: :any_skip_relocation, catalina:     "62d40ffb5207ea19d8f534116156fda96de6f0518ea37bd90977fcf6949f375e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6b0d8ef0502ffdc24597af7c55e2c3a82265ed7bce96038b6c7697872ab8722"
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
