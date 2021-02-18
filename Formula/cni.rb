class Cni < Formula
  desc "Some reference and example networking plugins, maintained by the CNI team"
  homepage "https://github.com/containernetworking/plugins"

  url "https://github.com/containernetworking/plugins.git",
    tag:      "v0.9.1",
    revision: "fa48f7515b50272b7106702a662fadbf2ead3d18"
  license "Apache-2.0"
  head "https://github.com/containernetworking/plugins.git"

  depends_on "go" => :build

  def install
    system "./build_linux.sh"
    bin.install (buildpath/"bin").children
  end

  test do
    system "#{bin}/loopback"
  end
end
