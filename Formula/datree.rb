class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.71",
    revision: "7799f7cc4d4cacbaba800944e5bd51f9a3e22a9b"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.71"
    sha256 cellar: :any_skip_relocation, big_sur:      "9ae173f578ffd04b8069db3aa55ff407e4f3c8ffdd6f1db4be7ad2a21a9edb67"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a62adedd3a92d108065a85af829a0000c0cede33f9f6411aaca48bd3883f580c"
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
