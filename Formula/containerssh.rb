class Containerssh < Formula
  desc "Launch containers on demand"
  homepage "https://containerssh.io/"

  url "https://github.com/ContainerSSH/ContainerSSH.git",
    tag:      "v0.4.0",
    revision: "c598ba7448f45611133882bdc4467aa104e73dd8"
  license "MIT"
  head "https://github.com/ContainerSSH/ContainerSSH.git"

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
