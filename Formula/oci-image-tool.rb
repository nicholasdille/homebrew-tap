class OciImageTool < Formula
  desc "OCI Image Tooling"
  homepage "https://opencontainers.org/"

  url "https://github.com/opencontainers/image-tools.git",
    tag:      "v1.0.0-rc1",
    revision: "7f6433100c1757a65c72f374080b6899f8152075"
  license "Apache-2.0"
  head "https://github.com/opencontainers/image-tools.git"

  livecheck do
    url "https://github.com/opencontainers/image-tools"
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/oci-image-tool-1.0.0-rc1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f11e0313bc925475cc6fd2f3d9857a3b60710bf1204bdfd1986bcffa4c099da6"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    dir = buildpath/"src/github.com/opencontainers/image-tools"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath
      system "make", "tool"
      bin.install "oci-image-tool"
    end
  end

  test do
    system bin/"oci-image-tool", "--version"
  end
end
