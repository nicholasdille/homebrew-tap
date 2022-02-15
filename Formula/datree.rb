class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.16",
    revision: "7630aa9788b6183b33c85e7bc8f725399b3c3dd7"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.16"
    sha256 cellar: :any_skip_relocation, big_sur:      "a41ea75de16f1153867838fb0ff37abaa790ad2a2e9aec3c63e19514d3681f2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7cfa8a0b8141e567ed3b04eec945b2fa6c5cecb4cd7d355523392b5803ffc47a"
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
