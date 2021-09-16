class Kink < Formula
  desc "Helper CLI to manage KinD clusters as Kubernetes pods"
  homepage "https://github.com/Trendyol/kink"

  url "https://github.com/Trendyol/kink.git",
    tag:      "v0.1.1",
    revision: "4d3a01f4e1817fe62c2ba48efa36f3ae21ddae50"
  license "Apache-2.0"
  head "https://github.com/Trendyol/kink.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/Trendyol/kink/cmd"
    commit = Utils.git_short_head
    build_date = Utils.safe_popen_read("date", "+%Y-%m-%dT%H:%M:%SZ")

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X #{pkg}.GitVersion=#{version}"\
                  " -X #{pkg}.gitCommit=#{commit}"\
                  " -X #{pkg}.buildDate=#{build_date}"\
                  " -X #{pkg}.gitTreeState=clean",
      "-o",
      bin/"kink"
  end

  test do
    system bin/"kink", "version"
  end
end
