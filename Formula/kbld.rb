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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kbld-0.33.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "97bd485e68d153aec8afa394b24424d29d19d92fe83f91081ca69794a79891c3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9821b65f0b78c396e6798b3907d271a80a573cb33aaed343de41e4772414fd15"
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
