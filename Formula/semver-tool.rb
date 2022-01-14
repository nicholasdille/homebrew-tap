class SemverTool < Formula
  desc "Semver bash implementation"
  homepage "https://github.com/fsaintjacques/semver-tool"

  url "https://github.com/fsaintjacques/semver-tool.git",
    tag:      "3.3.0",
    revision: "1306402f127fef8044ef594995aa24811bb39670"
  license "Apache-2.0"
  head "https://github.com/fsaintjacques/semver-tool.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/semver-tool-3.3.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "25e5896e8ff6033529269deb9968a575a0a5b727f6524adeb271357b54a43b44"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a3ad0d28919ef420d678aa737715bc7897364750b5e7a5a8172712f06dc78e23"
  end

  depends_on "go" => :build

  def install
    bin.install "src/semver"
  end

  test do
    system bin/"semver", "--version"
  end
end
