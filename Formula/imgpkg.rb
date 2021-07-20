class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.14.0",
    revision: "56c477ef73d5e347aec6acb4036dd4b52a181e4d"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.14.0"
    sha256 cellar: :any_skip_relocation, catalina:     "e8ea21a56b72335a30eac7a92b04c1deaca5b28cb74ae37294a7f99ce04a8d00"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1e0882f05dc152ec32fa9800610bb308f8b86f37715df339433f4ea09db30f58"
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
