class Faasd < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "https://github.com/openfaas/faasd.git",
    tag:      "0.12.5",
    revision: "5e29516f86b0674a34848e74edc06da177dfbd14"
  license "Apache-2.0"
  head "https://github.com/openfaas/faasd.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/faasd-0.12.5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4456c032b57daedc7212a60b46388ea192fbf842edb004aca3e83ffae7f98ffa"
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
