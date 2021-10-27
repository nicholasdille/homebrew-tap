class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.22.0",
    revision: "1456d0350d5215cd36350bab56b2a8ec72eb69d5"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.21.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "6bb7bb016a792a796e90d4baced9688c560be9239fd2f83415b653cb54fc6101"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9b0e186b03ee49a4535b3f80e381f95cb64b7d6584a43c34b372eaff15ee07a1"
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
