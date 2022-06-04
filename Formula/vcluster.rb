class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.9.0",
    revision: "90cdb19813b8a6137833741025fd4964abb8a024"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.9.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "4311a549cce33d2d42185ee4ab158bfb637e6551c45d3b6b7ea5dde07591fcd5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9dd856f72ea279301df44644abcf0da4bbb57cb3143c1a21d7a7ee6956fffd08"
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
