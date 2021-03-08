class FaasdRootless < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "file:///dev/null"
  version "1.0.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "Apache-2.0"

  depends_on "immortal"
  depends_on "nicholasdille/tap/containerd-rootless"
  depends_on "nicholasdille/tap/faasd"

  def install
    (buildpath/"faasd-rootless.sh").write <<~EOS
      #!/bin/bash

      echo DUMMY
    EOS
    bin.install "faasd-rootless.sh"

    (buildpath/"faasd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/faasd up
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
      cmd: #{HOMEBREW_PREFIX}/bin/faasd provider
      cwd: #{var}/lib/faasd-provider
      env:
        secret_mount_path: #{var}/lib/faasd/secrets
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
    system "#{HOMEBREW_PREFIX}/bin/faasd", "version"
  end
end
