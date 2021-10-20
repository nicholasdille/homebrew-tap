class SemverTool < Formula
  desc "Semver bash implementation"
  homepage "https://github.com/fsaintjacques/semver-tool"

  url "https://github.com/fsaintjacques/semver-tool.git",
    tag:      "3.2.0",
    revision: "20028cb53f340a300b460b423e43f0eac13bcd9a"
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
