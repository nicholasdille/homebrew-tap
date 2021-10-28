class Nsutils < Formula
  desc "Linux namespace utilities"
  homepage "https://github.com/rd235/nsutils"

  url "https://github.com/rd235/nsutils.git",
    tag: "master"
  version "0.0.0"
  license "GPL-2.0-only"

  livecheck do
    skip "No tags or releases"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "libbsd"
  depends_on "libcap"
  depends_on :linux

  def install
    system "autoreconf", "-if"
    system "./configure", "--prefix=#{prefix}"
    system "make"

    programs = %w[
      nshold
      nslist
      nsrelease
    ]
    namespaces = %w[
      cgroups
      ipc
      mnt
      net
      pid
      user
      uts
    ]

    programs.each do |program|
      bin.install program
      man1.install "#{program}.1"

      namespaces.each do |namespace|
        bin.install_symlink program => "#{namespace}#{program}"
        man1.install_symlink "#{program}.1" => "#{namespace}#{program}.1"
      end
    end

    bin.install "netnsjoin"
    man1.install "netnsjoin.1"
  end

  def caveats
    <<~EOS
      For netnsjoin to work correctly, you must run the following:

          sudo setcap cap_sys_ptrace,cap_sys_admin+p #{bin}/netnsjoin
    EOS
  end

  test do
    system "whereis", "nslist"
  end
end
