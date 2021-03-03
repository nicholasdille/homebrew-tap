class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://github.com/containers/buildah"

  url "https://github.com/containers/buildah.git",
    tag:      "v1.19.6",
    revision: "7aedb164287ed9c64ab38be2b3490782adadb894"
  license "Apache-2.0"
  head "https://github.com/containers/buildah.git"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "gpgme"
  depends_on "libassuan"
  depends_on "libseccomp"
  depends_on "nicholasdille/tap/cni"
  depends_on "nicholasdille/tap/runc"

  def install
    dir = buildpath/"src/github.com/containers/buildah"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GOPATH"] = buildpath
        
      system "make", "buildah"
      bin.install "bin/buildah"

      system "make", "-C", "docs", "GOMD2MAN=go-md2man"
      system "make", "-C", "docs", "install", "PREFIX=#{prefix}"
    end
  end

  test do
    system "#{bin}/buildah", "--version"
  end
end
