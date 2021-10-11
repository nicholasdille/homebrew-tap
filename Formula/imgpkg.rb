class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.20.0",
    revision: "e454c159d9c3e246cc41fe6470b0e12497abb959"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.20.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "d128461d24d1f9cd1b8b29e4153e95efdcdd2e34eaf16797974025f327735305"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "06b731780c3bcd38994f60d6f166573812833a46f63386dd9ad54b7e2400f11c"
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
