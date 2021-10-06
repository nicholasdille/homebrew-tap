class Ekz < Formula
  desc "EKS-D Kubernetes distribution for desktop"
  homepage "https://ekz-io.gitbook.io/ekz"

  url "https://github.com/chanwit/ekz.git",
    tag:      "v0.8.0",
    revision: "b0928b3b2ef854545df3d662e75c4ed0b9401fa7"
  license "Apache-2.0"
  head "https://github.com/chanwit/ekz.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X main.VERSION=#{version}",
      "-o", bin/"ekz",
      "./cmd/ekz"
  end

  test do
    system bin/"ekz", "--version"
  end
end
