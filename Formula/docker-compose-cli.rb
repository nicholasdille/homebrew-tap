class DockerComposeCli < Formula
  desc "Easily run your Compose application to the cloud with compose-cli"
  homepage "https://github.com/docker/compose-cli"

  url "https://github.com/docker/compose-cli.git",
    tag:      "v2.0.0-rc.2",
    revision: "3f50c5eff8951c05b640126234a79cc5f3a5b235"
  license "Apache-2.0"
  head "https://github.com/docker/compose-cli.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-cli-2.0.0-rc.2"
    sha256 cellar: :any_skip_relocation, catalina:     "f0c84e2af231fbfb732d12899d2494ccdb48c96efa853ea186f7a131a45d771a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1d5c43a44af9a8f1bf017f07e0393fc90ff7bcc58803329bfdfbcac554f729d5"
  end

  disable! date:    "2021-09-04",
           because: "does not offer the next v2 release candidate"

  deprecate! date:    "2021-09-02",
             because: "installs Docker compose v2 from a deprecated source"

  depends_on "go" => :build
  depends_on "docker" => :optional

  conflicts_with "docker-compose"

  def install
    pkg = "github.com/docker/compose-cli"
    tag = Utils.safe_popen_read("git", "describe", "--tags", "--match", "v[0-9]*")
    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-trimpath",
      "-tags", "e2e,kube",
      "-ldflags", "-s -w"\
                  " -X #{pkg}/internal.Version=#{tag}",
      "-o", lib/"docker/cli-plugins/docker-compose-cli",
      "./cli"

    system "go",
      "build",
      "-trimpath",
      "-tags", "e2e,kube",
      "-ldflags", "-s -w"\
                  " -X #{pkg}/internal.Version=#{tag}",
      "-o", lib/"docker/cli-plugins/docker-compose",
      "./cmd"

    (bin/"com.docker.cli").write <<~EOS
      #!/usr/bin/env bash
      exec #{HOMEBREW_PREFIX}/bin/docker "$@"
    EOS
  end

  def caveats
    <<~EOS
      You should create a symlink to enable the Docker CLI plugin:

      mkdir -p $HOME/.docker/cli-plugins
      ln -s #{lib}/docker/cli-plugins/docker-compose $HOME/.docker/cli-plugins
    EOS
  end

  test do
    system lib/"docker/cli-plugins/docker-compose", "compose", "version"
  end
end
