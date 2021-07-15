class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.1.741",
    revision: "ee6703589cb2a57b04074b532c1e82a5817b17a8"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  depends_on "go" => :build
  depends_on "goreleaser" => :build

  def install
    ENV["DATREE_BUILD_VERSION"] = version
    ENV["DATREE_DEPLOYMENT"] = ""

    id = "linux"
    on_macos do
      id = "datree-macos"
    end

    rm_rf ".brew_home"
    system "goreleaser", "build", "--id", id, "--single-target"
    bin.install "dist/datree_#{id}_amd64/datree"
  end

  test do
    system bin/"datree", "--version"
  end
end
