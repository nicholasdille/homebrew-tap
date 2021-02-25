class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.35.0",
    revision: "8e8ab96d9597e160ba6f813b1d92710c2a2d0068"
  license "Apache-2.0"
  revision 1
  head "https://github.com/vmware-tanzu/carvel-kapp.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.35.0_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "acb222505e599ca85a15ccacd989fa686418e2fedfc07d30cef97ecdd9f75281"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags=-buildid=", "-trimpath", "-o", "kapp", "./cmd/kapp"
    bin.install "kapp"
  end

  test do
    system "#{bin}/kapp", "--version"
  end
end
