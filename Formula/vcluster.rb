class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.10.1",
    revision: "0a11d6cfbf4ee87b65ebc3237331bc8666bb63f8"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.10.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "459abf3782f3e882b8ce333597a2dc12b884e39420f3cba4486643c53453ffd3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c4a420e5fe057b6278625940fae477f2b3713192a3937bcb983704cc6f0cfac5"
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
