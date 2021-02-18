class CniIsolation < Formula
  desc "CNI Bridge Isolation Plugin"
  homepage "https://github.com/containernetworking/plugins/issues/573"

  url "https://github.com/AkihiroSuda/cni-isolation.git",
    tag:      "v0.0.3",
    revision: "30b5a600a99fa573414f7658f501736a8e2542bd"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/cni-isolation.git"

  depends_on "go" => :build

  def install
    system "make"
    bin.install "bin/isolation"
  end

  test do
    system "#{bin}/isolation"
  end
end
