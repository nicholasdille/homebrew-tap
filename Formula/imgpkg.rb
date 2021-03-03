class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.5.0",
    revision: "75c1f5e644881a29872730e2c2851cb5a35d1cb6"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", "#{bin}/imgpkg",
      "./cmd/imgpkg/..."
  end

  test do
    system "#{bin}/imgpkg", "--version"
  end
end
