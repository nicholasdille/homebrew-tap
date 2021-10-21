class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.6",
    revision: "5cdd238ea2cc91d346d4c5fe48d9570505b6738c"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "74b26fff64b14827179a6908f80ef058e32cbd09741889fe73ad0420e80f2874"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3afb65d6ea1736d7e675ca88a9f864780a1f1976fb39e89737010dadd2e7098d"
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
