class OciRuntimeTool < Formula
  desc "Tool to build OCI compliant images"
  homepage "https://www.opencontainers.org/"

  url "https://github.com/opencontainers/runtime-tools.git",
    tag:      "v0.9.0",
    revision: "ee63cfa6f66491e78f8e63c37806d7a905eb836e"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runtime-tools.git"

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    dir = buildpath/"src/github.com/opencontainers/runtime-tools"
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
