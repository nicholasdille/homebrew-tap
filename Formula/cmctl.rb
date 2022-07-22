class Cmctl < Formula
  desc "CLI tool to manage cert-manager"
  homepage "https://cert-manager.io/docs/usage/cmctl/"

  url "https://github.com/jetstack/cert-manager.git",
    tag:      "v1.9.0",
    revision: "feb7979cb463c792c3178b3bee3421d74662d7ce"
  license "Apache-2.0"
  head "https://github.com/jetstack/cert-manager.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cmctl-1.9.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "c82027ebb10b1bc236e0b1a611e4dc6cff32333b76c22e2934e8d8700614d2a5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9aa155889f91456f10005d95480197aedbeff0b1934417226ffc536016b07295"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/cert-manager/cert-manager"
    ctl = "#{pkg}/cmd/ctl"

    commit = Utils.git_short_head

    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      *std_go_args(
        ldflags: "-s -w " \
                 "-X #{ctl}/pkg/build.name=cmctl " \
                 "-X #{ctl}/pkg/build/commands.registerCompletion=true " \
                 "-X #{pkg}/pkg/util.AppVersion=#{version} " \
                 "-X #{pkg}/pkg/util.AppGitState=clean " \
                 "-X #{pkg}/pkg/util.AppGitCommit=#{commit}",
      ),
      "./cmd/ctl/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} version --short --client")
  end
end
