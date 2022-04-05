class Cmctl < Formula
  desc "CLI tool to manage cert-manager"
  homepage "https://cert-manager.io/docs/usage/cmctl/"

  url "https://github.com/jetstack/cert-manager.git",
    tag:      "v1.8.0",
    revision: "e466a521bc5455def8c224599c6edcd37e86410c"
  license "Apache-2.0"
  head "https://github.com/jetstack/cert-manager.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cmctl-1.7.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "5d62ecef4719128babec7eb1074f50ccbd05f90b66ca7528c913ebc4cf1715d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "def907cfee9f7a1e6c0383bf7a93062e32ae777372cc4e9769e93de397032462"
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
