class Cosign < Formula
  desc "Container Signing"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/cosign.git",
    tag:      "v1.1.0",
    revision: "67934a685ddc83aa7b0b8a55c911e299117afac5"
  license "Apache-2.0"
  head "https://github.com/sigstore/cosign.git"

  livecheck do
    url :stable
    strategy :git do |tags|
      tags.map { |tag| tag[/^v(\d+\.\d+\.\d+)$/i, 1] }.compact
    end
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cosign-0.6.0"
    sha256 cellar: :any_skip_relocation, catalina:     "21db2c785a643a75c48789ab5e1a8ddb2477cda980180598a7693455a1583280"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1890c34ad8247326226ced6882ca96a2769bd509c834a35dbb34fd498d264e3a"
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
