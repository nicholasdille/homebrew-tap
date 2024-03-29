class FaasdRootless < Formula
  desc "Lightweight & portable faas engine"
  homepage "https://gumroad.com/l/serverless-for-everyone-else"

  url "file:///dev/null"
  version "1.0.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "Apache-2.0"

  livecheck do
    skip "Manual version"
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/faasd-rootless-1.0.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ae8282381b89c6ce8d0468e60b3010f16a8758192dbe91fd75d9130b292f7500"
  end

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
    pkgshare.install "faasd.yml"

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
    pkgshare.install "faasd-provider.yml"
  end

  def post_install
    mkdir_p etc/"immortal"
    cp pkgshare/"faasd.yml", etc/"immortal"
    cp pkgshare/"faasd-provider.yml", etc/"immortal"
    mkdir_p var/"run/faasd"
    mkdir_p var/"run/faasd-provider"
    mkdir_p var/"log"
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
