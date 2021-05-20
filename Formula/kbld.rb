class Kbld < Formula
  desc "Seamlessly incorporates image building and pushing into your workflows"
  homepage "https://carvel.dev/kbld"

  url "https://github.com/vmware-tanzu/carvel-kbld.git",
    tag:      "v0.30.0",
    revision: "085f54e597e0416807080b5bcf48a1fa4d679939"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kbld.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kbld-0.29.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4bee93d0c98da3a640348158fa4aec32c0911bc3a291257dedc993a633ac06e7"
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
