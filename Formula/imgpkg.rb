class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.14.0",
    revision: "56c477ef73d5e347aec6acb4036dd4b52a181e4d"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.13.0"
    sha256 cellar: :any_skip_relocation, catalina:     "d9bb0aa6594b00d1d9a92ee76a873aa488edcecf57aff77cde2fe2e25a4d7e83"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cec78448ee0120c256d7f68d739b3d29cbf797a5078e13dea988e85cffe80a86"
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
