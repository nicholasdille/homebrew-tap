class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.13.2",
    revision: "87675586d2cd7e988dbda7133d15bd78d0519154"
  license "Apache-2.0"
  head "https://github.com/containers/image.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.13.2"
    sha256 cellar: :any_skip_relocation, catalina:     "d559afc83be1197603abd9b727bb49b9c934a229767472cb2e6fd98548df73af"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0a179325eeb6f8d584a28a71aa90a49b00354f2ca112bdc3d9db8f22c699d90b"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "docs"
    man5.install Dir["docs/*.5"]
  end

  test do
    system "true"
  end
end
