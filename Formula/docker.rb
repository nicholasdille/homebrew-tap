class Docker < Formula
  desc "Pack, ship and run any application as a lightweight container"
  homepage "https://www.docker.com/"

  url "https://github.com/docker/cli.git",
      tag:      "v20.10.10",
      revision: "b485636f4b90ed5a91a1f403e65ffced469c641a"
  license "Apache-2.0"
  head "https://github.com/docker/cli.git",
    branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)(?:[._-]ce)?$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-20.10.10"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3e6700c5db41ab76112bf8e5258ad50b659d2b0447baf385cd73b4d09a386f12"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on arch: :x86_64
  depends_on :linux

  conflicts_with "docker-completion", because: "docker already includes these completion scripts"
  # conflicts_with "docker"

  def install
    dir = buildpath/"src/github.com/docker/cli"
    dir.install (buildpath/"").children
    cd dir do
      ENV["CGO_ENABLED"] = "0"
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "auto"
      ENV["DISABLE_WARN_OUTSIDE_CONTAINER"] = "1"
      system "make", "binary"

      os = "linux" if OS.linux?
      os = "darwin" if OS.mac?
      arch = "amd64"
      bin.install "build/docker-#{os}-#{arch}" => "docker"

      Pathname.glob("man/*.[1-8].md") do |md|
        section = md.to_s[/\.(\d+)\.md\Z/, 1]
        (man/"man#{section}").mkpath
        system "go-md2man", "-in=#{md}", "-out=#{man/"man#{section}"/md.stem}"
      end

      bash_completion.install "contrib/completion/bash/docker"
      fish_completion.install "contrib/completion/fish/docker.fish"
      zsh_completion.install "contrib/completion/zsh/_docker"
    end
  end

  test do
    system bin/"docker", "--version"
  end
end
