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
