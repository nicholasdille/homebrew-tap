class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.23.0",
    revision: "2b5ab8555429947e726c21da7cf45bc885466ed6"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.22.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "8b0c7ec35b92f7eddfa3c5a87bcf1d06a6c7b3c3f6cb4f20aa0392adb053c8a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d8fbbcfcf25dde46eac91855d27d4f84b62bc784eb45dcb7d0952ee3d50a697c"
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
