class Libexecs < Formula
  desc "Execute a file taking its arguments from a string"
  homepage "https://github.com/virtualsquare/s2argv-execs"

  url "https://github.com/virtualsquare/s2argv-execs.git",
    tag:      "1.3",
    revision: "2f3f79c8141ec6d3a671f34ecab60f70d3f39593"
  license "LGPL-2.1"
  head "https://github.com/virtualsquare/s2argv-execs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "cmake" => :build
  depends_on "gcc" => :build

  def install
    mkdir buildpath/"build"
    cd buildpath/"build" do
      system "cmake", "..", "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  test do
    system "test", "-f", "#{lib}/libexecs.so"
  end
end
