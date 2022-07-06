class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.15.1",
    revision: "9937e08209b8d266e2266d4454205acb4fdfe8e7"
  license "MIT"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.15.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "c9aca585e4176913fd5863e12a22b0ca0f70760f469fe7a20d40dc4400ebc256"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "60dcc44d0a6cea7a129739964933593dcc00706ccd074787e6c75ad32e6d963c"
  end

  depends_on "go" => :build

  def install
    commit = Utils.git_short_head
    build_date = Utils.safe_popen_read("date", "+%Y-%m-%dT%H:%M:%SZ")

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X main.version=#{version} " \
                  "-X main.commit=#{commit} " \
                  "-X main.date=#{build_date} " \
                  "-X main.builtBy=Homebrew",
      "-o",
      bin/"bin",
      "."
  end

  test do
    system bin/"bin", "--version"
  end
end
