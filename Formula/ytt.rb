class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.39.0",
    revision: "cb4ee408e8892385c467bc496a567328cbe45690"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.39.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "67e7fdaeb2213b176d9ca94694e786c02f420c5de915bbcbac9fadb7e31d683e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "045783ed06603390671c28328d19266f326899c5ec651de96e8bcfecfa3576f2"
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
