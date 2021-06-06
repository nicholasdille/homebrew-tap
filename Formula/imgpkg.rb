class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.9.0",
    revision: "ae922e428fa1d68fe6b625acc6b8d1c1ede69242"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.9.0"
    sha256 cellar: :any_skip_relocation, catalina:     "972bcb404cfd0d906e2479ee4a7dde65c3cdbb9a891da74e434c04c71394c5db"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "954bb0a862ec282607a2d7db50cb4f4a1776454a83b111018eefb4dd2340c4a9"
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
