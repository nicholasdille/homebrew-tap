class Faasd < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "https://github.com/openfaas/faasd.git",
    tag:      "0.11.1",
    revision: "6262ff2f4a05f0bc8d773e01dc81b0301c0d69d5"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/faasd-0.11.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "366320cc1c79ffeaac2758772f3280cd6f4efc036d304793918646b961c12984"
  end

  depends_on "go" => :build
  depends_on "openssl" => :build
  depends_on "immortal"
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

    (var/"run/faasd").mkpath
    (var/"log").mkpath
    (buildpath/"faasd.yml").write <<~EOS
      cmd: #{bin}/faasd up
      cwd: #{var}/lib/faasd
      pid:
        parent: #{var}/run/faasd/parent.pid
        child: #{var}/run/faasd/child.pid
      log:
        file: #{var}/log/faasd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
      require:
      - faasd-provider
    EOS
    (etc/"immortal").install "faasd.yml"

    (var/"run/faasd-provider").mkpath
    (var/"log").mkpath
    (buildpath/"faasd-provider.yml").write <<~EOS
      cmd: #{bin}/faasd provider
      cwd: #{var}/lib/faasd-provider
      env:
        secret_mount_path: {{.SecretMountPath}}
        basic_auth: true
      pid:
        parent: #{var}/run/faasd-provider/parent.pid
        child: #{var}/run/faasd-provider/child.pid
      log:
        file: #{var}/log/faasd-provider.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
      require:
      - containerd
    EOS
    (etc/"immortal").install "faasd-provider.yml"
  end

  test do
    system "#{bin}/faasd", "version"
  end
end
