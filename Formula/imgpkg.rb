class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.20.0",
    revision: "e454c159d9c3e246cc41fe6470b0e12497abb959"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.19.0"
    sha256 cellar: :any_skip_relocation, catalina:     "86bb31f2678dddfc9b7f842bdf3541a4631c3eaf2d8244a9003354558fe54812"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f23bf2467b9af080ac7a1351d4a2e7902607c861045774ee7c3b0ae667d8318e"
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
