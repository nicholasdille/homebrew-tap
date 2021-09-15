class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.2.0",
    revision: "aa5d23b86d09c2275dd3a7317b7c98cc30a8eee7"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git do |tags|
      tags.map { |tag| tag[/^v(\d+\.\d+\.\d+)$/i, 1] }.compact
    end
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.1.0"
    sha256 cellar: :any_skip_relocation, catalina:     "37c190e3beccab04a63e0cbb9fde90be18b65cced630c4cf89918af29b947a4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ddf2d2700d09f69a7d9129f1b6849409aa97d529dd10416492f49024dfc5ed99"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/sigstore/cosign/cmd/cosign/cli"
    commit = Utils.git_short_head
    build_date = Utils.safe_popen_read("date", "+'%Y-%m-%dT%H:%M:%SZ'")

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X #{pkg}.gitVersion=#{version}"\
                  " -X #{pkg}.gitCommit=#{commit}"\
                  " -X #{pkg}.gitTreeState=clean"\
                  " -X #{pkg}.buildDate=#{build_date}",
      "-o", bin/"cosign",
      "./cmd/cosign"
  end

  test do
    system bin/"cosign", "version"
  end
end
