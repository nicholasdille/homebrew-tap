class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.35.0",
    revision: "8e8ab96d9597e160ba6f813b1d92710c2a2d0068"
  license "Apache-2.0"
  revision 2
  head "https://github.com/vmware-tanzu/carvel-kapp.git"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", "#{bin}/kapp",
      "./cmd/kapp"
  end

  test do
    system "#{bin}/kapp", "--version"
  end
end
