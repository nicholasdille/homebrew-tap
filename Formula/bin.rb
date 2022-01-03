class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.12.0",
    revision: "90d58208eae92d6f95b8cbe17f745291bc66a738"
  license "MIT"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.12.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "b3cd6de1be7d308ad5edc855c68856fc4d3789a06d004b00e5df0aea5647e93a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "68dc745359dc8d06d3c4c7747033feac76ef8cbd327f6a579b6b5c62fde09675"
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
