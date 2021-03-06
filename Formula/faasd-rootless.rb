class FaasdRootless < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "https://github.com/openfaas/faasd.git",
    tag:      "0.11.1",
    revision: "6262ff2f4a05f0bc8d773e01dc81b0301c0d69d5"
  license "Apache-2.0"

  depends_on "immortal"
  depends_on "nicholasdille/tap/containerd-rootless"
  depends_on "nicholasdille/tap/faasd"

  def install
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

  def post_install
    (var/"run/faasd").mkpath
    (var/"log").mkpath
  end

  def caveats
    <<~EOS
      TODO: brew immortal
    EOS
  end

  test do
    system "#{bin}/faasd", "version"
  end
end
