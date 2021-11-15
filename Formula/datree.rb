class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.47",
    revision: "01d7826f599ee7ee949d3170e65ab3ae2ca04330"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.47"
    sha256 cellar: :any_skip_relocation, big_sur:      "7837b9a673b044c04fe636b998a26e6c4dac693191a5e29b02d02e2de486c49c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "71f444c229514ce48b84f6ff10a4bea648f1d5e7a2e0a8f3334b7183ffbcbc78"
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
