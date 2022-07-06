class Cmctl < Formula
  desc "CLI tool to manage cert-manager"
  homepage "https://cert-manager.io/docs/usage/cmctl/"

  url "https://github.com/jetstack/cert-manager.git",
    tag:      "v1.8.2",
    revision: "f1943433be7056804e4f628ff0d6685a132c407b"
  license "Apache-2.0"
  head "https://github.com/jetstack/cert-manager.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cmctl-1.8.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "89896204bce83cf62c76c10e79a5fc5f3074977beee1d14667968d5ef5cd0fe2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f772f040556df007a23eed03652c2f7a2e76d425ec34aa0181a99d1c5ebaf8b8"
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
