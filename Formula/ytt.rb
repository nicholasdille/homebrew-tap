class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io/"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.30.0",
    revision: "98c00dd09dae7a75f3c31e89e7d855671d6a9dce"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  depends_on "go" => :build
  depends_on "zip" => :build

  def install
    system "./hack/build-binaries.sh"
    bin.install "ytt-linux-amd64" => "ytt"
  end

  test do
    system "#{bin}/ytt", "--version"
  end
end
