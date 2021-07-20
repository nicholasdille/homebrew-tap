class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.8.0",
    revision: "a638c4aae4dca8eb6a339bfd40af4f8dca7b5231"
  license "MIT"
  head "https://github.com/marcosnils/bin.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.8.0"
    sha256 cellar: :any_skip_relocation, catalina:     "676c97ae54978522f2aa9b8b33e0aa7da540ca958b2d3b1a70aab424e98463c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0c570d422801ac21de76f5974db8a8c0694aae542cf5d75c61f8ea2e1894ecaf"
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
