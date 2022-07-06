class Buildah < Formula
  desc "Tool that facilitates building OCI images"
  homepage "https://github.com/containers/buildah"

  url "https://github.com/containers/buildah.git",
    tag:      "v1.26.2",
    revision: "19159983d3ecdb16df97eb4c887902363066b474"
  license "Apache-2.0"
  head "https://github.com/containers/buildah.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildah-1.26.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a7be4e662d86c48c19125030a663aafa2a1c0bfde6e36907107ba5e277823b1d"
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
