class Stargzify < Formula
  desc "Container Registry Filesystem"
  homepage "https://github.com/google/crfs"

  url "https://github.com/google/crfs.git",
    revision: "71d77da419c90be7b05d12e59945ac7a8c94a543"
  version "0.0.0"
  license "BSD-3-Clause"
  head "https://github.com/google/crfs.git"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"stargzify",
      "stargz/stargzify/stargzify.go"
  end

  test do
    system bin/"stargzify", "--help"
  end
end
