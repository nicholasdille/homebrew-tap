class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.8.0",
    revision: "69d89d174f943959b44840a7915ae618d9ecc871"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.7.0"
    sha256 cellar: :any_skip_relocation, catalina:     "2ec23e0a7c3bc82b714283387f6fc8e2b68a21534886930624ccacd63e0a5b32"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8cc6e4bee83c1c64f53f6e141437e6270157dcf617de8bcb2b68893ad0acd02"
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
