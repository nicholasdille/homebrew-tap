class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.26.0",
    revision: "00d383ce94e22370027801f874d125a03c01cfd8"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.26.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "b4637d7e11e431b57aa3b10fc486867510ef0d63beb99a0945a47bf72f0bf1b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "70777ae15cbbfc6632c40ad5b6b1eb6a8f61534f6858c0d582cc04f48862caec"
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
