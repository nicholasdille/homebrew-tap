class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.8.0",
    revision: "1a4f4ee2d696dba7829373fab889234559069067"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.8.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "fd7a91d581b57b875559d71e59b292a271d6353359f7ed697a0d9ca5783641ff"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "42a75d3780cff14fe87d817247fc495413c1af81ce58d1ba56d21517492da7da"
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
