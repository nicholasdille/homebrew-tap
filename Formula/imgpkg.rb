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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.30.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "ae025d6f58377af6640fa346e8d82fd3408496d8d777f63001c3cfe17a2a8951"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b83a94a7dc6fc91abfb8d1f6616ec4a799dc8871984074037d045f0a76c433d9"
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
