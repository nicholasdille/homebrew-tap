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

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/notation-0.7.0-alpha.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "93a7377139bf220ed2d2a002c83c114515f5b5482fbee2557cdf31345dce95bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d2181c2c8e29e0d2b1d0f23149545662b70807a13ce5abbcee065e4b54222090"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X $(MODULE)/internal/version.BuildMetadata=v#{version}",
      "-o",
      bin/"notation",
      "./cmd/notation"

    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X $(MODULE)/internal/version.BuildMetadata=v#{version}",
      "-o",
      bin/"docker-generate",
      "./cmd/docker-generate"

    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X $(MODULE)/internal/version.BuildMetadata=v#{version}",
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
