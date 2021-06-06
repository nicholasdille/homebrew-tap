class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.34.0",
    revision: "df5e906b0e3ef3ae51dde8f0248bb5108e8283c4"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.33.0"
    sha256 cellar: :any_skip_relocation, catalina:     "422ed411d9fbd74ddec68dd789a858e81fe6b9fb1568399744337214ab573441"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6abb26bd11ec63a9c7768ab769b9aaf4b2c7e28bf97f6653eba46019204fb40d"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", bin/"ytt",
      "./cmd/ytt"
  end

  test do
    system bin/"ytt", "--version"
  end
end
