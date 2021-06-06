class Containerssh < Formula
  desc "Launch containers on demand"
  homepage "https://containerssh.io/"

  url "https://github.com/ContainerSSH/ContainerSSH.git",
    tag:      "v0.4.1",
    revision: "2714a9d3805691444186bfaf4e00389cadfe333d"
  license "MIT"
  head "https://github.com/ContainerSSH/ContainerSSH.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerssh-0.4.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1e59e6a492a6defbc54ba04693efeac677acf4d229e09cf905afc43fe4cfab19"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"containerssh",
      "./cmd/containerssh"

    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"containerssh-auditlog-decoder",
      "./cmd/containerssh-auditlog-decoder"

    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"containerssh-testauthconfigserver",
      "./cmd/containerssh-testauthconfigserver"
  end

  test do
    system bin/"containerssh", "--help"
  end
end
