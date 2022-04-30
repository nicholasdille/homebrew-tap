class Kbld < Formula
  desc "Seamlessly incorporates image building and pushing into your workflows"
  homepage "https://carvel.dev/kbld"

  url "https://github.com/vmware-tanzu/carvel-kbld.git",
    tag:      "v0.33.0",
    revision: "212ceeedbdc5ef53d4890b3c00019bab912fb3e6"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kbld.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kbld-0.32.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "15e10b4182782d063c90d68551a21626f83a28389b101311a60da49d73b9ec1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "743c99fa2c54adeb62daa4e66af8820fc88b600d4e0ed9480e81aebc1462338d"
  end

  depends_on "go" => :build

  def install
    system "./hack/build.sh"
    bin.install "kbld"
  end

  test do
    system bin/"kbld", "version"
  end
end
