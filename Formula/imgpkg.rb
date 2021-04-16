class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.6.1",
    revision: "e94169ec55578315b86efe3e2df649a1ddede5fe"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.6.1"
    sha256 cellar: :any_skip_relocation, catalina:     "b8b7d86d722af251bc5e7b2e6061b4438eb8d077895fc67e695cdccdf3377b5e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "180a37c2a2838c61838f140bc3309b89666cd7354f9bad43888e233aa350c718"
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
