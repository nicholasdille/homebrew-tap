class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.22",
    revision: "5958d6ef42b9d036178fdb9d9e1366cd526153ea"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.22"
    sha256 cellar: :any_skip_relocation, big_sur:      "fd72e3ef34b64b5d3879d512c7da93a7152b9c5ba6b6a942e9a9a58c89623c8a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f1ae3abb0619b9f5554673ba52eaa018b15e8af12f92f7e225cafed79b1512be"
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
