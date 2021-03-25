class Kbld < Formula
  desc "Seamlessly incorporates image building and pushing into your workflows"
  homepage "https://carvel.dev/kbld"

  url "https://github.com/vmware-tanzu/carvel-kbld.git",
    tag:      "v0.29.0",
    revision: "5f051be5f7b9541a3633b03eba0c791a08c16c57"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kbld.git"

  depends_on "go" => :build

  def install
    system "./hack/build.sh"
    bin.install "kbld"
  end

  test do
    system bin/"kbld", "version"
  end
end
