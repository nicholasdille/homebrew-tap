class Notation < Formula
  desc "Signatures as standard items in the registry ecosystem (Notary v2)"
  homepage "https://github.com/notaryproject/notation"

  url "https://github.com/notaryproject/notation.git",
    tag:      "v0.7.0-alpha.1",
    revision: "2f51db34942fbc17a1992d88c0b282e9e3e85a1b"
  license "Apache-2.0"
  head "https://github.com/notaryproject/notation.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X $(MODULE)/internal/version.BuildMetadata=v#{version}",
      "-o",
      bin/"notation",
      "./cmd/notation"

    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X $(MODULE)/internal/version.BuildMetadata=v#{version}",
      "-o",
      bin/"docker-generate",
      "./cmd/docker-generate"

    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X $(MODULE)/internal/version.BuildMetadata=v#{version}",
      "-o",
      bin/"docker-notation",
      "./cmd/docker-notation"
  end

  def caveats
    <<~EOS
      You should create a symlink to enable the Docker CLI plugin:
      mkdir -p $HOME/.docker/cli-plugins
      ln -s #{lib}/docker/cli-plugins/docker-{generate,notation} $HOME/.docker/cli-plugins
    EOS
  end

  test do
    system bin/"notation", "--version"
  end
end
