class Kbld < Formula
  desc "Seamlessly incorporates image building and pushing into your workflows"
  homepage "https://carvel.dev/kbld"

  url "https://github.com/vmware-tanzu/carvel-kbld.git",
    tag:      "v0.31.0",
    revision: "460ebbd1ab811f607d0d6401af2a646f910bc3d6"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kbld.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kbld-0.31.0"
    sha256 cellar: :any_skip_relocation, catalina:     "a4b7159671d3238b79f4d93928d927c7c7a96620b65681a8ef4b0a6f05d9fd1f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "14ab37208558f6fdc1c017fd4fa445e5f2257b3bee3ed02adcb165231f7d90d7"
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
