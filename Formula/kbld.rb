class Kbld < Formula
  desc "Seamlessly incorporates image building and pushing into your workflows"
  homepage "https://carvel.dev/kbld"

  url "https://github.com/vmware-tanzu/carvel-kbld.git",
    tag:      "v0.30.0",
    revision: "085f54e597e0416807080b5bcf48a1fa4d679939"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kbld.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kbld-0.30.0"
    sha256 cellar: :any_skip_relocation, catalina:     "4dd9f34c2c0f175fe5a9ca31569d33e98953c83404c45638c54f20f94dab52f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "32ba7ed0fdbd1483398f1f2a64e536ec56cde9441f153b73a2c9166a80a8b4c5"
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
