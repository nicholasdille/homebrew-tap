class KubeBench < Formula
  desc "Checks whether Kubernetes is deployed according to security best practices"
  homepage "https://github.com/aquasecurity/kube-bench"

  url "https://github.com/aquasecurity/kube-bench.git",
    tag:      "v0.6.9",
    revision: "93a167a9177ff300a0e25da91a746f2888206ac6"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/kube-bench.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.9"
    sha256 cellar: :any_skip_relocation, big_sur:      "3321f8661f4f0cd7c30c926b4944b277cfff5834119933ba437fa03ea96c6ed0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a19c6f8e850f75568ba4af9ead50279ea65ed246ed22c338b252e34f602b8fb8"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/aquasecurity/kube-bench/cmd"

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X #{pkg}.KubeBenchVersion=#{version} " \
                  "-X #{pkg}.cfgDir=#{etc}/kube-bench",
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
