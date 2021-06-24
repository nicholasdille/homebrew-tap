class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.12.0",
    revision: "c1fd21ad776ceb6ee1b9ee8967e8876c1e2fb896"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.11.0"
    sha256 cellar: :any_skip_relocation, catalina:     "cb77e8bc9d52b1b4d7e435b9ca65803206c77e921ce1909aab10a988f30b3562"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8c5102759a6c0ea91795206b4652eb480bcb3cce3c394577f7f0a44d58bc3482"
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
