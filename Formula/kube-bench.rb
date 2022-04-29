class KubeBench < Formula
  desc "Checks whether Kubernetes is deployed according to security best practices"
  homepage "https://github.com/aquasecurity/kube-bench"

  url "https://github.com/aquasecurity/kube-bench.git",
    tag:      "v0.6.8",
    revision: "d77d9a368a1241c7cf2bebfe23e74a668efad5f2"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/kube-bench.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.8"
    sha256 cellar: :any_skip_relocation, big_sur:      "c9b02cc830f972973f674246badfc94fee20145f61574225b443291319f6589c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d87887393b255e294e9bf9635e92b3a521c7fa9ca30c7b601a396b45febdc0c9"
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
