class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.35.0",
    revision: "8e8ab96d9597e160ba6f813b1d92710c2a2d0068"
  license "Apache-2.0"

  depends_on "go" => :build
  depends_on "nicholasdille/tap/ytt" => :build
  depends_on "zip" => :build

  def install
    system "./hack/build-binaries.sh"
    bin.install "kapp-linux-amd64" => "kapp"
  end

  test do
    system "#{bin}/kapp", "--version"
  end
end
