class Kink < Formula
  desc "Helper CLI to manage KinD clusters as Kubernetes pods"
  homepage "https://github.com/Trendyol/kink"

  url "https://github.com/Trendyol/kink.git",
    tag:      "v0.2.1",
    revision: "b8e45f558ff2bd67fa90211e4365a8bb8fe67875"
  license "Apache-2.0"
  head "https://github.com/Trendyol/kink.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kink-0.2.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "7946b3488475bf6e9157dea7c725556e99585a29bbf915d59913979cf5a7ddc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0281dbba772b052ef506277c7c4c59ff94cf41e9b85b4e422e9cfc362ccd7f06"
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
