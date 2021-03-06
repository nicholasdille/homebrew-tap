class Faasd < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "https://github.com/openfaas/faasd.git",
    tag:      "0.11.1",
    revision: "6262ff2f4a05f0bc8d773e01dc81b0301c0d69d5"
  license "Apache-2.0"
  revision 1
  head "https://github.com/openfaas/faasd.git"

  depends_on "git" => :build
  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "openssl" => :build
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
    system "#{bin}/faasd", "version"
  end
end
