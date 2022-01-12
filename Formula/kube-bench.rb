class KubeBench < Formula
  desc "Checks whether Kubernetes is deployed according to security best practices"
  homepage "https://github.com/aquasecurity/kube-bench"

  url "https://github.com/aquasecurity/kube-bench.git",
    tag:      "v0.6.6",
    revision: "d3cbc6447630129ab02d2c77b9418e258ed5a846"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/kube-bench.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.5"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "4f581fc134c9172e957bbbcbe260937a9d1947aba1e4e1309723ca1b732eb346"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e2ddab1c54f0274ccd00550beb7e31042af6d1a159b98fee155330aac5f2c55b"
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
