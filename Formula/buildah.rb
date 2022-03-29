class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://github.com/containers/buildah"

  url "https://github.com/containers/buildah.git",
    tag:      "v1.25.0",
    revision: "cdcaaf51b37d14cd160c046a8eaf02201699eb74"
  license "Apache-2.0"
  head "https://github.com/containers/buildah.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildah-1.25.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ea4394927b19e7ada7ec834a99e72ba1310d6ad7344801834d24b115bbe59122"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "gpgme"
  depends_on "libassuan"
  depends_on "libgpg-error"
  depends_on :linux
  depends_on "device-mapper" => :recommended
  depends_on "libseccomp" => :recommended

  def install
    ENV.O0

    buildtags = []
    # buildtags << "apparmor" # libapparmor
    buildtags << "seccomp" if build.with? "libseccomp"
    buildtags << "exclude_graphdriver_btrfs" if build.without? "btrfs"
    buildtags << "btrfs_noversion" if build.with? "btrfs"
    buildtags << "libdm_no_deferred_remove" if build.without? "device-mapper"
    # buildtags << "libsubid" # shadow

    system "make", "bin/buildah", "TAGS=#{buildtags.join(",")}"
    bin.install "bin/buildah"

    bash_completion.install "contrib/completions/bash/buildah"

    system "make", "-C", "docs", "GOMD2MAN=go-md2man"
    man1.install Dir["docs/*.1"]
  end

  test do
    system bin/"buildah", "--version"
  end
end
