class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.23.1",
    revision: "125c7114f2e63d2753297754985d15194dc7c2f3"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.23.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "61ca3662bbd03d8fd55679acffb7d62f4e8b75666bf72b11cc5ff78496bb9a5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "24d8deb6eaf9ea2faef3af1028ec2c3961cad3a7f8706b0452676ca87c7bf033"
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
