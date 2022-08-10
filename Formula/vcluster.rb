class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.11.1",
    revision: "893710319456ddfd33a463ed0d590d77b7fa1b95"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "fe6daed05af75dac934f37d5a0338f3e565cd33e9269126923053947b79b8da2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a3df8f82d8ba43d9d1a25a9917deede33d8c00221fc26bc1348e3536574a5733"
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
