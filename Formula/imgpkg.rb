class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.10.0",
    revision: "c3c3bdd01be75974854dac4907bc24258f4b0c2b"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.10.0"
    sha256 cellar: :any_skip_relocation, catalina:     "09894988c489070797bccf19bb3ad2c477e5746fc3dd11f5f2cc5a8e3f5293c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b0dd0362602cbce8dfc388f8a6fbd9bbb6e2f82aedeafd9313b50788c484e6aa"
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
