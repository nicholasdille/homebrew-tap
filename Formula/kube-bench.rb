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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.4"
    sha256 catalina:     "95797944a7e452f4413cde868b28843a544766a831d90fa592ae02e9ce94a412"
    sha256 x86_64_linux: "b197dd8e861987b6eb9230130cc137e7087ed020e213330b35ebe581887a928d"
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
