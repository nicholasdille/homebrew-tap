class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.10",
    revision: "45cfc6b007c507589ad21e869ee24cc415cc605a"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.10"
    sha256 cellar: :any_skip_relocation, big_sur:      "4ac8f5e7857a41e8fe18db1ccbad31e59e41a33d1fefecab9a0606aa3804a387"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8ae33348918d20340133ac47dc506caf3d31edafc9476f513a0fad9c3ba3cfb7"
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
