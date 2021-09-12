class KubeBench < Formula
  desc "Checks whether Kubernetes is deployed according to security best practices"
  homepage "https://github.com/aquasecurity/kube-bench"

  url "https://github.com/aquasecurity/kube-bench.git",
    tag:      "v0.6.4",
    revision: "10ba0adb2d45eb45b9178b51ede45d4dfcae46a0"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/kube-bench.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.3"
    sha256 catalina:     "eab07fee8561b6d707b5e7338acdee42bf7e0aa3f17e9bd5d40bd4a3c2334b5d"
    sha256 x86_64_linux: "728ca849b9703da5ea274b5a6f3b58e1f2b2cebf225be54efa6730657600fd73"
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

    (etc/"kube-bench").install Dir["cfg/*"]
  end

  test do
    system bin/"kube-bench", "version"
  end
end
