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

  depends_on "go" => :build

  def install
    bin.install "src/semver"
  end

  test do
    system bin/"semver", "--version"
  end
end
