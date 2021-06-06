class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.9.0",
    revision: "ae922e428fa1d68fe6b625acc6b8d1c1ede69242"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.8.0"
    sha256 cellar: :any_skip_relocation, catalina:     "451b3a26b221270baa5f2321f200c3c13c7919c1468e73c98f30610f6a42b26e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7538f6f7b4c7b9aff4eaea8aba9a4e795a86a0081246797340934b41ab1bb3e9"
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
