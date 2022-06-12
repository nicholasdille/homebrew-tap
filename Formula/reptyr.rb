class Reptyr < Formula
  desc "Reparent a running program to a new terminal"
  homepage "https://github.com/nelhage/reptyr"

  url "https://github.com/nelhage/reptyr.git",
    tag:      "reptyr-0.9.0",
    revision: "a21260effc5bdf8879feb18252f02ebe03a1698c"
  license "MIT"
  head "https://github.com/nelhage/reptyr.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/reptyr-0.9.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fe438fffb6a29563f4fbea3f976c1028bbe0ceb47c4ba529ba14eb8b2dbb1e96"
  end

  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    ENV["LDFLAGS"] = "-static"
    system "make", "reptyr"
    bin.install "reptyr"

    man1.install "reptyr.1"
    bash_completion.install "reptyr.bash" => "reptyr"
  end

  test do
    system bin/"reptyr", "-v"
  end
end
