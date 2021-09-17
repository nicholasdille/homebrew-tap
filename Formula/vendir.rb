class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.23.0",
    revision: "f65c73335261488c3328c98c99ef123ceeee5def"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.23.0"
    sha256 cellar: :any_skip_relocation, catalina:     "4dc43286efce227c885a71ba939187869325a4e148d860cbb5e6e0b6bcc0dd15"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78df4c8f31778a32efd12c096c983316a960e2c539f793c6fc6f59cbfba30083"
  end

  depends_on "go" => :build

  def install
    system "./hack/build.sh"
    bin.install "vendir"
  end

  test do
    system bin/"vendir", "version"
  end
end
