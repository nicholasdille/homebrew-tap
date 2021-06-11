class OciImageTool < Formula
  desc "OCI Image Tooling"
  homepage "https://opencontainers.org/"

  url "https://github.com/opencontainers/image-tools.git",
    tag:      "v1.0.0-rc3",
    revision: "25e557a203ff15022e7e01b9a498737b2d643e92"
  license "Apache-2.0"
  head "https://github.com/opencontainers/image-tools.git"

  livecheck do
    url "https://github.com/opencontainers/image-tools"
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/oci-image-tool-1.0.0-rc3"
    sha256 cellar: :any_skip_relocation, catalina:     "ef037d05de434f8c71f605926c7e39ba45cb5f11d937f32194bbddfcaa3da892"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2786659fab798448a0a4dfe3d2b890dae925a359e1e3c19203e48bcde9d96d85"
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
