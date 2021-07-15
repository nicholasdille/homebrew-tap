class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.1.741",
    revision: "ee6703589cb2a57b04074b532c1e82a5817b17a8"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git"

  depends_on "go" => :build

  def install
    pkg = "github.com/datreeio/datree"
    ENV['CGO_ENABLED'] = "0"

    system "go", "build",
      "-tags", "main",
      "-ldflags", "-X #{pkg}/cmd.CliVersion=#{version}",
      "-o", bin/"datree",
      "./main.go"
  end

  test do
    system bin/"datree", "version"
  end
end
