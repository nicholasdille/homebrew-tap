class Cmctl < Formula
  desc "CLI tool to manage cert-manager"
  homepage "https://cert-manager.io/docs/usage/cmctl/"

  url "https://github.com/jetstack/cert-manager.git",
    tag:      "v1.7.2",
    revision: "2e0bfc87d0c63c473c31a17f4c8c65e89806dc16"
  license "Apache-2.0"
  head "https://github.com/jetstack/cert-manager.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cmctl-1.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "c4f858a274c09ca69c9d0f4cf4b7d5697fbfc3c0408bfc46ebf24b76c5eeb313"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ed633614f093f7601babca4801c9e003dd1d3f72176c22e088edbd1ca3fa323f"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/jetstack/cert-manager"
    ctl = "#{pkg}/cmd/ctl"

    commit = Utils.git_short_head

    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      *std_go_args(
        ldflags: "-s -w "\
                 "-X #{ctl}/pkg/build.name=cmctl "\
                 "-X #{ctl}/pkg/build/commands.registerCompletion=true "\
                 "-X #{pkg}/pkg/util.AppVersion=#{version} "\
                 "-X #{pkg}/pkg/util.AppGitState=clean "\
                 "-X #{pkg}/pkg/util.AppGitCommit=#{commit}",
      ),
      "./cmd/ctl/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} version --short --client")
  end
end
