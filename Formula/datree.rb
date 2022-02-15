class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.16",
    revision: "7630aa9788b6183b33c85e7bc8f725399b3c3dd7"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.16"
    sha256 cellar: :any_skip_relocation, big_sur:      "a05dc653576b5c25c22c901155ee294164cb16ab3acbca11ffadaa5af5332241"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "95b8324fe1d61c6f88ae95c2a192a64db7239b3e8322835fbae2195998338014"
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
