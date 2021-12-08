class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.62",
    revision: "0a567d526af1a0d597b50c9847625e788ba04203"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.62"
    sha256 cellar: :any_skip_relocation, big_sur:      "f2fab5fd1b0903d3ed5cf775bf30053c92dea5dede378a4842b0029bc8d83b47"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a7c0dc51068822aa356f630f08eeeb9f4531946b1a9414914e66ec598ece4fa8"
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
