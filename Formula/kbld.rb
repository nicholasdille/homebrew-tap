class Kbld < Formula
  desc "Seamlessly incorporates image building and pushing into your workflows"
  homepage "https://carvel.dev/kbld"

  url "https://github.com/vmware-tanzu/carvel-kbld.git",
    tag:      "v0.34.0",
    revision: "e9e1b30c5023fa1e553d8563cbf4e872dafb6e94"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kbld.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kbld-0.34.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "3c1cb10302ba238bfccff7c8317d30e7d93c137a9b1527d8611f42ff34ace7e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "744c69bd68f5fefdd0061b6743d4f3018c9933d6eb1fbece779878096e58ac56"
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
