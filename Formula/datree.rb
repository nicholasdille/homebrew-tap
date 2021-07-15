class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.1.741",
    revision: "ee6703589cb2a57b04074b532c1e82a5817b17a8"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.1.741"
    sha256 cellar: :any_skip_relocation, catalina:     "44cac66a9d4c2226604e9dcfd61e6a82ce7fffe1ce424c7529a0780907c6ef76"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "21b820cae3b3530159e0bee09d82d613301c8b52b9eabed10e655bacc68c120f"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/datreeio/datree"
    ENV["CGO_ENABLED"] = "0"

    system "go", "build",
      "-tags", "main",
      "-ldflags", "-X #{pkg}/cmd.CliVersion=#{version}",
      "-o", bin/"datree",
      "./main.go"
  end

  test do
    system bin/"datree", "version"
  end
end
