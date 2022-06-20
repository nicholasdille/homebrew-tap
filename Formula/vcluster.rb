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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.10.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "ce9e6b7b3e1550525ae8d4205f7da40d1de0d4b4d0f80eedbd8233bddab09139"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9306735ec13707478a93c6430490387cd7ba550a16a82ba22db2735022911b55"
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
