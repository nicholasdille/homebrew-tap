class KubeBench < Formula
  desc "Checks whether Kubernetes is deployed according to security best practices"
  homepage "https://github.com/aquasecurity/kube-bench"

  url "https://github.com/aquasecurity/kube-bench.git",
    tag:      "v0.6.5",
    revision: "0e6184186f1c32016608785141194b9611c7a3cc"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/kube-bench.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kube-bench-0.6.5"
    sha256 catalina:     "c7dcd3434a1de611568ad4c71168baf39d6442cf4d613e467dd940ca0cb6a988"
    sha256 x86_64_linux: "0bf0d923f91ec3450f69a8ce9190b0863ae440e78fd26c348ac31ff0fcd247d8"
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
