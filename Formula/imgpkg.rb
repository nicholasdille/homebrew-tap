class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.26.0",
    revision: "00d383ce94e22370027801f874d125a03c01cfd8"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.25.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "2bfb039f515ba7d24ba9ede8523f7710ea2895d71aa30d23f2235aa4fd5659e1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "113f82258e6f0811cfef7fda87fd8432a92afce912ef05195ca47dd29df621bf"
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
