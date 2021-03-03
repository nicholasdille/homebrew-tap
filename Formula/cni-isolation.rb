class CniIsolation < Formula
  desc "CNI Bridge Isolation Plugin"
  homepage "https://github.com/containernetworking/plugins/issues/573"

  url "https://github.com/AkihiroSuda/cni-isolation.git",
    tag:      "v0.0.3",
    revision: "30b5a600a99fa573414f7658f501736a8e2542bd"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/cni-isolation.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-isolation-0.0.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af0d6007f6a0ecf0b14ed1dc650e30249b4c6f24b4a6c43f76babf92eece6ebc"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make"
    bin.install "bin/isolation"
  end

  test do
    system "#{bin}/isolation"
  end
end
