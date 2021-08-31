class Docker < Formula
  desc "Pack, ship and run any application as a lightweight container"
  homepage "https://www.docker.com/"

  url "https://github.com/docker/cli.git",
      tag:      "v20.10.8",
      revision: "3967b7d28e15a020e4ee344283128ead633b3e0c"
  license "Apache-2.0"
  head "https://github.com/docker/cli.git",
    branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)(?:[._-]ce)?$/i)
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  conflicts_with "docker-completion", because: "docker already includes these completion scripts"
  conflicts_with "docker"

  def install
    dir = buildpath/"src/github.com/docker/cli"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GOPATH"] = buildpath
      ENV["GO111MODULE"] = "auto"
      ENV["DISABLE_WARN_OUTSIDE_CONTAINER"] = "1"
      system "make", "binary"
      on_linux do
        bin.install "build/docker-linux-amd64" => "docker"
      end
      on_macos do
        puts Utils.safe_popen_read("ls", "-l", "build")
      end

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
