class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.4",
    revision: "057eb1ecc138704ddb6d58174ba16fd6b94ef5dc"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "c77e5621b6ed735fd6302432b24af4eafec1073dcb28b177ea5157fae3141824"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "31bdca7fd794f28f6975c1787bfe5606ae16f5a60e908628f5f20efedd26a9db"
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
