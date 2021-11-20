class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.23.1",
    revision: "125c7114f2e63d2753297754985d15194dc7c2f3"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.23.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "7e04f2578f207bb73a157ecf194633b197be9a8ffe4430e4fbe7082c959d5b6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc42c84d3ced259aa22c7e63a0cba9db8f43b1a26a575982c0f2bf43e99d4482"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", bin/"imgpkg",
      "./cmd/imgpkg/..."
  end

  test do
    system bin/"imgpkg", "--version"
  end
end
