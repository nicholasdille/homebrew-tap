class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.15.0",
    revision: "a798f72f7d3cecb24a2078c391858293479f7eb4"
  license "MIT"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.14.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "87d4d0c4b1ba094baa00e0a6ab080e60565a454b6628ef88ecee755150f28610"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9d642c18c8c6c7cd8ec850b2894921074bc915f087a291978160ea55d869b178"
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
