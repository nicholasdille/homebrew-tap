class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.24.0",
    revision: "a0785f6d01e99b1d8516f18120e419e66ed49bb8"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.24.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "3af9c6bf53f5ce5b20459610c85c7a517f4ff67e4e665ae887494df9de26bc94"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fce8d6db26a037d5add1eae4801a0d55848851eedf9aaf3a509a705ed9eb866b"
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
