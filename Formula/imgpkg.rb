class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.19.0",
    revision: "8f065a1e29a016a773f550b272a767f3d5926a07"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.18.0"
    sha256 cellar: :any_skip_relocation, catalina:     "00d7c8c37b6398b49052cae75b38a892d6b6b46339535e60147ee5a8c954c1df"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e30a173f6f804eb1fc4061b010461da2e1e8187ada04fdf19a452d1b54c084cd"
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
