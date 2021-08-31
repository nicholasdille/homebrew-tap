class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.17.0",
    revision: "7d2fd285eaa493c5460b5739104e6876fcc04217"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.17.0"
    sha256 cellar: :any_skip_relocation, catalina:     "6f959f08664367e95079877a4a9865e79d45d2d599d8f2c1865716519b8d4d2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "44066584dbdebd235bd104d5607414d9022a34bb29d31ddb56d694b4b3935433"
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
