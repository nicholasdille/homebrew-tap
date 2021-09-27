class CniIsolation < Formula
  desc "CNI Bridge Isolation Plugin"
  homepage "https://github.com/containernetworking/plugins/issues/573"

  url "https://github.com/AkihiroSuda/cni-isolation.git",
    tag:      "v0.0.4",
    revision: "a703d960bee6c8d368c99526f3defc12ae9ac410"
  license "Apache-2.0"
  revision 1
  head "https://github.com/AkihiroSuda/cni-isolation.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    system "make"
    bin.install "bin/isolation"
  end

  test do
    system bin/"isolation"
  end
end
