class Cmctl < Formula
  desc "CLI tool to manage cert-manager"
  homepage "https://cert-manager.io/docs/usage/cmctl/"

  url "https://github.com/jetstack/cert-manager.git",
    tag:      "v1.9.1",
    revision: "4486c01f726f17d2790a8a563ae6bc6e98465505"
  license "Apache-2.0"
  head "https://github.com/jetstack/cert-manager.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cmctl-1.9.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "37a5e8d44ea984138584895c9bc9509ee5737ce1fada6203e3d1c06db7dc08c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "036585e793a76e31e00c8fbd9f3edfc032a7acd8e2dde4b350fec58226b50237"
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
