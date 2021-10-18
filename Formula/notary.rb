class Notary < Formula
  desc "Allows anyone to have trust over arbitrary collections of data"
  homepage "https://github.com/notaryproject/notary"

  url "https://github.com/notaryproject/notary.git",
    tag:      "v0.6.1",
    revision: "d6e1431feb32348e0650bf7551ac5cffd01d857b"
  license "Apache-2.0"
  head "https://github.com/notaryproject/notary.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    pkg = "github.com/theupdateframework/notary"
    commit = Utils.git_short_head
    ctimevar = "-X #{pkg}/version.GitCommit=#{commit} -X #{pkg}/version.NotaryVersion=#{version}"
    go_ldflags = "-w #{ctimevar}"

    buildtags = [
      #"pkcs11",
      "netgo"
    ]

    ENV["GO111MODULE"] = "auto"
    ENV["GOPATH"] = buildpath

    if OS.linux?
      ENV["CGO_ENABLED"] = "0"
      ENV["GOFLAGS"] = "-mod=vendor"
      go_ldflags += " -extldflags -static"
    end

    dir = buildpath/"src/github.com/theupdateframework/notary"
    dir.install (buildpath/"").children
    cd dir do
      system "go", "build",
        "-tags", buildtags.join(" "),
        "-ldflags", go_ldflags,
        "-o", bin/"notary-server",
        "./cmd/notary-server"

      system "go", "build",
        "-tags", buildtags.join(" "),
        "-ldflags", go_ldflags,
        "-o", bin/"notary-signer",
        "./cmd/notary-signer"

      system "go", "build",
        "-tags", buildtags.join(" "),
        "-ldflags", go_ldflags,
        "-o", bin/"notary",
        "./cmd/notary"
    end
  end

  test do
    system bin/"notary", "--version"
  end
end
