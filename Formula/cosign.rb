class Cosign < Formula
  desc "Container Signing"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v0.4.0",
    revision: "2e1191e354cf905b335439916dc8116c3bc362f9"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"

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
    system bin/"cosign", "--help"
  end
end
