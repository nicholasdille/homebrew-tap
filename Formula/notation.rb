class Notation < Formula
  desc "Signatures as standard items in the registry ecosystem (Notary v2)"
  homepage "https://github.com/notaryproject/notation"

  url "https://github.com/notaryproject/notation.git",
    tag: "main"
  version "0.0.0"
  license "Apache-2.0"
  head "https://github.com/notaryproject/notation.git",
    branch: "main"

  livecheck do
    skip "No version information available"
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/notation-0.0.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "1cf162ed99f375a8e129c368535053aad0215281568beaf67403f07915bdf2c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5250ad9fe5293455a8eb278d92c34e1d1d514ada6da07365ac0e6681c42a7b7d"
  end

  depends_on "go" => :build

  def install
    commit = Utils.git_short_head

    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X $(MODULE)/internal/version.BuildMetadata=#{commit}.unreleased",
      "-o",
      bin/"notation",
      "./cmd/notation"

    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X $(MODULE)/internal/version.BuildMetadata=#{commit}.unreleased",
      "-o",
      bin/"docker-generate",
      "./cmd/docker-generate"

    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X $(MODULE)/internal/version.BuildMetadata=#{commit}.unreleased",
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
