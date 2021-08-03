class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.17.0",
    revision: "7d2fd285eaa493c5460b5739104e6876fcc04217"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.16.0"
    sha256 cellar: :any_skip_relocation, catalina:     "8402033e1c76efc3bdf10c6da5e030f9c8c123e58bcafec0a43816891d2b3a4b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "376d5f2853eaaad5049665531bfc85831dafd6e8e67c982f03602ef6cfc1d2e6"
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
