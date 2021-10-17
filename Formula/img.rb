class LinuxNewuidmapRequirement < Requirement
  fatal true

  satisfy(build_env: false) { which(TOOL).present? }

  def message
    <<~EOS
      Please install the uidmap package.
    EOS
  end

  TOOL = "newuidmap".freeze
end

class LinuxNewgidmapRequirement < Requirement
  fatal true

  satisfy(build_env: false) { which(TOOL).present? }

  def message
    <<~EOS
      Please install the uidmap package.
    EOS
  end

  TOOL = "newgidmap".freeze
end

class Img < Formula
  desc "Standalone, daemon-less, unprivileged container image builder"
  homepage "https://blog.jessfraz.com/post/building-container-images-securely-on-kubernetes/"

  url "https://github.com/genuinetools/img.git",
    tag:      "v0.5.11",
    revision: "5b908689b176d81225d227631b4170dbee9ab6f9"
  license "MIT"
  head "https://github.com/genuinetools/img.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/img-0.5.11"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "064911afdb0a9a86ef97a0613bd5c62eff34c9a2a786a5ac4dd68a3302bb09db"
  end

  depends_on "go" => :build
  depends_on "libseccomp" => :build
  depends_on "pkg-config" => :build
  depends_on :linux
  depends_on LinuxNewgidmapRequirement
  depends_on LinuxNewuidmapRequirement
  depends_on "nicholasdille/tap/runc"

  def install
    pkg = "github.com/genuinetools/img"
    commit = Utils.git_short_head

    buildtags = %w[
      seccomp
      noembed
    ]
    system "go", "build",
      "-tags", buildtags.join(" "),
      "-ldflags", "-w"\
                  " -X #{pkg}/version.GITCOMMIT=#{commit}"\
                  " -X #{pkg}/version.VERSION=#{version}",
      "-o", bin/"img",
      "."
  end

  test do
    system bin/"img", "--version"
  end
end
