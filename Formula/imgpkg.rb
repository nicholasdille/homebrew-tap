class Imgpkg < Formula
  desc "Store application configuration files in Docker/OCI registries"
  homepage "https://carvel.dev/imgpkg"

  url "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    tag:      "v0.27.0",
    revision: "acb7d5d82842869f1a2b230a216c9d829d91e061"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-imgpkg.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgpkg-0.27.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "fa1d8d71713f7c5b6e18d865a93c59bd58dee1ae849cb30eda5d6df702f38e00"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2fa840cdc840d2ddc02568e1511bccbf7e32e46dbc432517490ffb3263dfdfc4"
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
