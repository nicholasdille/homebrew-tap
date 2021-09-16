class Kink < Formula
  desc "Helper CLI to manage KinD clusters as Kubernetes pods"
  homepage "https://github.com/Trendyol/kink"

  url "https://github.com/Trendyol/kink.git",
    tag:      "v0.1.1",
    revision: "4d3a01f4e1817fe62c2ba48efa36f3ae21ddae50"
  license "Apache-2.0"
  revision 1
  head "https://github.com/Trendyol/kink.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kink-0.1.1_1"
    sha256 cellar: :any_skip_relocation, catalina:     "63d3af3a8a31d1503857b5efb2d74fb68f11b5319d953e9f9e50b27a40a0721f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5653dc2ba3bda9fb7e6bcdc946108d9316e88bea62bbc1f3d492e71ccd8c3e24"
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

    # bash completion
    output = Utils.safe_popen_read(bin/"kink", "completion", "bash")
    (bash_completion/"kink").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"kink", "completion", "fish")
    (zsh_completion/"kink.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"kink", "completion", "zsh")
    (zsh_completion/"_kink").write output
  end

  test do
    system bin/"kink", "version"
  end
end
