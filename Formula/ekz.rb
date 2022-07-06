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
    regex(/^v(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ekz-0.8.0"
    sha256 cellar: :any_skip_relocation, catalina:     "e36490a822697f17d23470c670ce825d0dcaeb4987dd283c6a041908d73e7094"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "35f791b91899aad2c22027c9f34519346a34f260753e283ca99d3f65acaffed8"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X main.VERSION=#{version}",
      "-o", bin/"ekz",
      "./cmd/ekz"
  end

  test do
    system bin/"ekz", "--version"
  end
end
