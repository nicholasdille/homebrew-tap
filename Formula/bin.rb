class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.10.1",
    revision: "56ca9da13bdf966afeacfda6cf1979bb5ee1f64a"
  license "MIT"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.10.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "5cb17af5a5d060137343274ad22d6895d4bea5f78b2f6132ad157cd43af671eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2e37cd90b93f2d95141a3af236ae6816ec56e72576ed77f0e1420b7127f4f877"
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
