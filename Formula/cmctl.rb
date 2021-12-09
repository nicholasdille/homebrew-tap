class Cmctl < Formula
  desc "CLI tool to manage cert-manager"
  homepage "https://cert-manager.io/docs/usage/cmctl/"

  url "https://github.com/jetstack/cert-manager.git",
    tag:      "v1.6.1",
    revision: "5ecf5b5617a4813ea8115da5dcfe3cd18b8ff047"
  license "Apache-2.0"
  head "https://github.com/jetstack/cert-manager.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cmctl-1.6.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "d6bdbb4d307de9bbe614c87222c96faa1efa548676a8bb9715cc643befe2e4de"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6aa536147b722e306ada5785a23452182753ffe3ace837beb6edd1806753e49f"
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
