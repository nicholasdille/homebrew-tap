class Cosign < Formula
  desc "Container Signing"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v0.5.0",
    revision: "5cb21aa7fbf9ef25dbb8179785a05d695e4cef2c"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-0.5.0"
    sha256 cellar: :any_skip_relocation, catalina:     "920e0ddd60494b1cff736395cb2b7e3f8695bb73aa68ce79b64198198a6a44d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c79f06f6b083c35b91baa26bec4eac2d2e3295b5f9fe27652a9e1e03f76b703"
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
    system bin/"cosign", "--help"
  end
end
