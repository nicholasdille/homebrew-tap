class KubeBench < Formula
  desc "Checks whether Kubernetes is deployed according to security best practices"
  homepage "https://github.com/aquasecurity/kube-bench"

  url "https://github.com/aquasecurity/kube-bench.git",
    tag:      "v0.6.7",
    revision: "962671990669a9fd6fd8a930b064cc1f8624acc1"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/kube-bench.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "8932b4bfa6d157a444ceea9087ac465210863b57f130ce3d4bc521a463334e85"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c0f929ad446195ed7abda629b33ae56fa8a11c1b60bd640801946f79fb02d878"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/aquasecurity/kube-bench/cmd"

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X #{pkg}.KubeBenchVersion=#{version}"\
                  " -X #{pkg}.cfgDir=#{etc}/kube-bench",
      "-o",
      bin/"kube-bench",
      "."

    pkgshare.install Dir["cfg/*"]
  end

  def post_install
    mkdir_p etc/"kube-bench"
    cp Dir[pkgshare/"*.cfg"], etc/"kube-bench"
  end

  test do
    system bin/"kube-bench", "version"
  end
end
