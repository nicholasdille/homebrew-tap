class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.7.1",
    revision: "dc0ff6f96e9c96fe2caa77e79c2dffc921b4fd49"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.7.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "53bc2ea13c4ac7ad35d47d0aa5bae2ac2a55f44ae530beb60c6012ca91e389ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1f859b2f5864748d7f81a00a8c01bb73e701acdc84315cf1652908d6cf517df5"
  end

  depends_on "go" => :build
  depends_on arch: :x86_64

  def install
    commit = Utils.git_short_head
    build_date = Utils.safe_popen_read("date", "+%Y-%m-%dT%H:%M:%SZ")
    system "go", "build",
      "-a",
      "-ldflags", "-s -w"\
                  " -X main.commitHash=#{commit} "\
                  " -X main.buildDate=#{build_date}"\
                  " -X main.version=#{version}",
      "-o", bin/"vcluster",
      "cmd/vclusterctl/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} --version")
  end
end
