class OciImageTool < Formula
  desc "OCI Image Tooling"
  homepage "https://opencontainers.org/"

  url "https://github.com/opencontainers/image-tools.git",
    tag:      "v1.0.0-rc1",
    revision: "7f6433100c1757a65c72f374080b6899f8152075"
  license "Apache-2.0"
  head "https://github.com/opencontainers/image-tools.git"

  depends_on "make" => :build
  depends_on "go" => :build

  def install
    dir = buildpath/"src/github.com/opencontainers/image-tools"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "on"
      ENV["GOPATH"] = buildpath
      system "make", "tool"
    end
  end

  test do
    system "#{bin}/oci-runtime-tool", "--version"
  end
end
