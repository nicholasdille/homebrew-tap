class Distribution < Formula
  desc "Toolkit to pack, ship, store, and deliver container content"
  homepage "https://github.com/distribution/distribution"

  url "https://github.com/distribution/distribution.git",
    tag:      "v2.8.1",
    revision: "b5ca020cfbe998e5af3457fda087444cf5116496"
  license "Apache-2.0"
  head "https://github.com/distribution/distribution.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "nicholasdille/tap/gometalinter" => :build
  depends_on "nicholasdille/tap/vndr" => :build
  depends_on :linux

  def install
    dir = buildpath/"src/github.com/docker/distribution"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      system "vndr"
      system "make", "binaries"
      bin.install "bin/registry"
    end
  end

  test do
    system bin/"registry", "--version"
  end
end
