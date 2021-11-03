class Cosign < Formula
  desc "Container Signing"
  homepage "https://github.com/sigstore/cosign"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.3.0",
    revision: "a91aa202a01b830dafa969bb46f168e9c44580bd"
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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-1.3.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "fb3311db9ea841a4681984fae4e50cb6d52b97766b913716ee1f825fa5d01a48"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ecc046f65e21de0e137cf134823a48e5614691f27a59cbae838bb8ea9fc5f8ff"
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
