class Containerssh < Formula
  desc "Launch containers on demand"
  homepage "https://containerssh.io/"

  url "https://github.com/ContainerSSH/ContainerSSH.git",
    tag:      "0.4.0-PR4",
    revision: "4eb9d631bfb7b2678c867d236aef99517db0a2d0"
  license "MIT"
  head "https://github.com/ContainerSSH/ContainerSSH.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerssh-4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ca9583acaa938cc4f1957e5cf76a0c22d1d1dd021ff6f657ea96f27445dd4152"
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
