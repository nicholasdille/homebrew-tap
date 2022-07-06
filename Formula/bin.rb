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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.15.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "b9487e15364e43b9b6bc6d6eae964144e274f08f496e589642ac0c4a7f003e45"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c0ecfa60618bf6c681dfe98aacaa62dcc31e4ceec30626c934235bfe75911896"
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
