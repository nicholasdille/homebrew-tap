class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.13.1",
    revision: "d8ffb9fc666ae9f75afa2981d069b2b654c0d0bc"
  license "MIT"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.13.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "0533a0aab2ca5d20105b1a87b09b266c38d8d1bd27517de7c9654e473a21e63f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ef103b150e69bd93b00b269f7148ef5b8144f5f7ce79c12f740a25c7509465db"
  end

  depends_on "go" => :build

  def install
    commit = Utils.git_short_head
    build_date = Utils.safe_popen_read("date", "+%Y-%m-%dT%H:%M:%SZ")

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X main.version=#{version}"\
                  " -X main.commit=#{commit}"\
                  " -X main.date=#{build_date}"\
                  " -X main.builtBy=Homebrew",
      "-o",
      bin/"bin",
      "."
  end

  test do
    system bin/"bin", "--version"
  end
end
