class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.16.0",
    revision: "2e07ec7e8e577697676d3482d9ecd9847da9cf36"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.15.0"
    sha256 cellar: :any_skip_relocation, catalina:     "54b49f74ba0aca552f6a63d31956a3e6227b34d87b2c8df0d01d4811ffbf8356"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7eab3570b13012557213595d6c32439f86b581f9b1da66ca69dca55be1a94ea"
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
