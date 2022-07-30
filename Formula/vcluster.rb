class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.11.0",
    revision: "bd4f6197eb6de06e9225e9214e302de3acb02945"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.10.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "a7b5999ebc77198091df47ee26c0ebc4750ac3abf774ec99b360417af8703fd6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bfdc49c765c70bab8a3ac6e65eff32c064c5f3b672e662b32f330602dc5e411d"
  end

  depends_on "go" => :build
  depends_on arch: :x86_64

  def install
    commit = Utils.git_short_head
    build_date = Utils.safe_popen_read("date", "+%Y-%m-%dT%H:%M:%SZ")
    system "go", "build",
      "-a",
      "-ldflags", "-s -w " \
                  "-X main.commitHash=#{commit} " \
                  "-X main.buildDate=#{build_date} " \
                  "-X main.version=#{version}",
      "-o", bin/"vcluster",
      "cmd/vclusterctl/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} --version")
  end
end
