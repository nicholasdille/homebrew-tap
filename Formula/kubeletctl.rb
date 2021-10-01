class Kubeletctl < Formula
  desc "Client for kubelet"
  homepage "https://github.com/cyberark/kubeletctl"

  url "https://github.com/cyberark/kubeletctl.git",
    tag:      "v1.8",
    revision: "6f4d05cb121a44ff339948bc028194f1848e5dc9"
  license "Apache-2.0"
  head "https://github.com/cyberark/kubeletctl.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeletctl-1.8"
    sha256 cellar: :any_skip_relocation, catalina:     "898ec7902fdfb9f85bde9166d3243e4be2a14c02ace75fe455c6abf5a99d9377"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "562aba1f093c3f7600ca2ceba52f0ceb46179053aee23a54fdc3c6ebfacf4472"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "mod", "vendor"
    system "go",
      "build",
      "-mod=vendor",
      "-ldflags", "-s -w",
      "-o", bin/"kubeletctl",
      "."
  end

  test do
    system bin/"kubeletctl", "version"
  end
end
