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
    url :stable
    strategy :git
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
