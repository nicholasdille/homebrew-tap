class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.30.0",
    revision: "d0e3ab7361eca6b280b4f8fdde531f6e205dc24b"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.29.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "eb2a130fbf69c456691125e6145f95c42a72082ba3a83a265ae95f81fc20e410"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7e2d3941b7ae66160ff14092acf5e63ad57a004819d7d05ab27f6656b8539a3"
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
