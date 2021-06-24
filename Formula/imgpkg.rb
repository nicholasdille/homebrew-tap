class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.12.0",
    revision: "c1fd21ad776ceb6ee1b9ee8967e8876c1e2fb896"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.12.0"
    sha256 cellar: :any_skip_relocation, catalina:     "d125ffe9b81461023c16b4285d6ce313e2670e5afe8e7d2668da2a5cb50de56b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "afe67ffd34484e40b3ecb2d1b874de64e0fda12b0da9618130481e556186e53d"
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
