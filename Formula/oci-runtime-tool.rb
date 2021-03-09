class OciRuntimeTool < Formula
  desc "Tool to build OCI compliant images"
  homepage "https://www.opencontainers.org/"

  url "https://github.com/opencontainers/runtime-tools.git",
    tag:      "v0.9.0",
    revision: "ee63cfa6f66491e78f8e63c37806d7a905eb836e"
  license "Apache-2.0"
  head "https://github.com/opencontainers/runtime-tools.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/oci-runtime-tool-0.9.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc259be8ac071e104d1b59bd8372a8dd39442e818be505d1f0ca70c3e1e58285"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    dir = buildpath/"src/github.com/opencontainers/runtime-tools"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath
      system "make", "tool"
      bin.install "oci-runtime-tool"
    end
  end

  test do
    system "#{bin}/oci-runtime-tool", "--version"
  end
end
