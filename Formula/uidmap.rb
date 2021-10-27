class Uidmap < Formula
  desc "Shadow"
  homepage "https://github.com/shadow-maint/shadow"

  url "https://github.com/shadow-maint/shadow.git",
    tag:      "v4.9",
    revision: "6f9124b7f73d6e31f96a0d441d7a3e54d835642d"
  license ""
  head "https://github.com/shadow-maint/shadow.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "binutils" => :build
  depends_on "byacc" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "gettext" => :build
  depends_on "itstool" => :build
  depends_on "libtool" => :build
  depends_on "libxml2" => :build
  depends_on "libxslt" => :build
  depends_on "llvm" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux

  resource "manpages" do
    url "https://github.com/shadow-maint/shadow/releases/download/v4.9/shadow-4.9.tar.gz"
    sha256 "6c4627ff9c9422b96664517ae753c944f2902e92809d0698b65f5fef11985212"
  end

  def install
    # cp "#{Formula["docbook"].prefix}/docbook/xml/4.5/catalog.xml", buildpath
    # system "xmlcatalog", "--noout",
    #   "--add",
    #   "uri",
    #   "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl",
    #   "file://#{Formula["docbook-xsl"].prefix}/docbook-xsl/manpages/docbook.xsl",
    #   "./catalog.xml"
    # system "xmlcatalog", "--noout",
    #   "--add",
    #   "uri",
    #   "http://docbook.sourceforge.net/release/xsl/current/manpages/profile-docbook.xsl",
    #   "file://#{Formula["docbook-xsl"].prefix}/docbook-xsl/manpages/profile-docbook.xsl",
    #   "./catalog.xml"

    system "./autogen.sh",
      # "--prefix=#{prefix}",
      "--disable-nls",
      # "--enable-man",
      # "--with-xml-catalog=./catalog.xml",
      "--without-audit",
      "--without-selinux",
      "--without-acl",
      "--without-attr",
      "--without-tcb",
      "--without-nscd",
      "--without-btrfs"

    system "make"

    bin.install "src/newuidmap"
    bin.install "src/newgidmap"

    # man1.install man/"man1/newuidmap.1"
    # man1.install man/"man1/newgidmap.1"
    # man5.install man/"man5/subuid.5"
    # man5.install man/"man5/subgid.5"

    resource("manpages").stage do
      puts Utils.safe_popen_read("ls", "-l")
      man1.install "man/man1/newuidmap.1"
      man1.install "man/man1/newgidmap.1"
      man5.install "man/man5/subuid.5"
      man5.install "man/man5/subgid.5"
    end
  end

  def caveats
    <<~EOS
      new{u,g}idmap requires /etc/subuid.conf. See "man subuid.conf"
    EOS
  end

  test do
    system bin/"bin", "--version"
  end
end
