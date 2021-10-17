class Faasd < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "https://github.com/openfaas/faasd.git",
    tag:      "0.14.3",
    revision: "ea62c1b12dd1ae1de794e6dd260351cfbd1a6759"
  license "Apache-2.0"
  head "https://github.com/openfaas/faasd.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/faasd-0.14.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a418563770f73a9bef7ca07d1bb200663dd87304eb00ae87604d7a0ab7ea80f9"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "openssl" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/containerd"
  depends_on "faas-cli" => :recommended

  def install
    system "make", "dist"

    bin.install "bin/faasd"
    (var/"lib/faasd").install "docker-compose.yaml"
    (var/"lib/faasd").install "prometheus.yml"
    (var/"lib/faasd").install "resolv.conf"

    (var/"lib/faasd/secrets/basic-auth-user").write <<~EOS
      admin
    EOS

    output = Utils.safe_popen_read("openssl", "rand", "-hex", "64")
    (var/"lib/faasd/secrets/basic-auth-password").write output
  end

  test do
    system bin/"faasd", "version"
  end
end
