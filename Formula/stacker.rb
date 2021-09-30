class Stacker < Formula
  desc "Build OCI images from a declarative format"
  homepage "https://github.com/anuvu/stacker"

  url "https://github.com/anuvu/stacker.git",
    tag:      "v0.11.0",
    revision: "7113229dcc00cd1a27dbf825160e9a90b49b70f8"
  license "Apache-2.0"
  head "https://github.com/anuvu/stacker.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on "gpgme" => :build
  depends_on "libcap" => :build
  depends_on "lxc" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  def install
    system "go",
      "build",
      "-tags", "exclude_graphdriver_devicemapper containers_image_openpgp osusergo netgo static_build",
      "-ldflags", "-X main.version=#{version}"\
                  "-X main.lxc_version="\
                  "-extldflags '-static'",
      "-o", bin/"stacker",
      "./cmd"
  end

  test do
    system bin/"stacker", "--version"
  end
end
