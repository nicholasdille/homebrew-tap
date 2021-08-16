class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.7.1",
    revision: "0b1e6cef6e916ac16dd0066686fd7f26e92f5982"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.7.1"
    sha256 cellar: :any_skip_relocation, catalina:     "50234b6c59a9925df8e99c71bd44049f495f0a5692e57f36ee733fa1f536fe96"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "07c5a15e6df9945eec7f0fd83987bca9be7bf67b22664a77e94168e42037de8d"
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
