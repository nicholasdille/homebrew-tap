class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.11.0",
    revision: "5b773e46b57c299d3433f93dd0faa77877d87320"
  license "MIT"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "9a23b5acb39e0df466e6b7891e0cb047f66ac241a65fb2710f56bab6c09cfd8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7c95e8a123a701828ae68fc8492e716cfc7ae84402addb2e377734f61bd6b5f2"
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
