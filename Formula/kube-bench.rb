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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.7"
    sha256 cellar: :any_skip_relocation, big_sur:      "82d6eaac6f16ebb6e442417abac1f9a0c2784b5ccf37a64c5cddc8bf4417eb33"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4df2c3cab8b18602d61072631191756ce40fc93eae97bbc4847f16b7792ae27d"
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
