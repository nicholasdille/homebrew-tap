class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.13.4",
    revision: "76faac49cb8a8bfd80e0d853e9eed4503918475b"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.13.4"
    sha256 cellar: :any_skip_relocation, catalina:     "182d5f4b793a3dee60eb80cbe5053b627d3cc6fad6db7cfe7000ea8f8c52dc56"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cc3ba52117f0d31c6a882bb6c7ff7430661cbe9de9096df3b7582c0ad03730ed"
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
