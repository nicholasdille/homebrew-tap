class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.29.0",
    revision: "2fcf08d9a6d6a69846dd96502c945d9c1d09b3fc"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.28.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "985c2b01507a3e40623486a09f536cd150f201d6e858fdd04a05a2f658bf8631"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "156c7f1b6110f9b90a82ed1e7ad372d38f80ec6562491515d39eb36663f4ad7f"
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
