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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerssh-0.4.1"
    sha256 cellar: :any_skip_relocation, catalina:     "8a2aa0a50aaae969e5bed80a9d4cabc73203854c1173e34c2ed18be3ffbbb65d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "045f3aa281787fc7d33b6d04c3e7d05ad1747e996681bf000e8832efc36ff225"
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
