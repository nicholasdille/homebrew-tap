class Uidmap < Formula
  desc "XXX"
  homepage "https://github.com/shadow-maint/shadow"

  url "https://github.com/shadow-maint/shadow.git",
    tag:      "4.8.1",
    revision: "2cc7da6058152ec0cd338d4e15d29bd7124ae3d7"
  license ""
  head "https://github.com/shadow-maint/shadow.git"

  depends_on "autoconf" => :build
  depends_on "gettext" => :build
  depends_on "automake" => :build
  depends_on "gcc@10" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    #bin.install "dist/kubeone"

    # manpages
    #(man/"man1").mkpath
    #system "#{bin}/kubeone", "document", "man", "-o", man/"man1"

    # bash completion
    #output = Utils.safe_popen_read("#{bin}/kubeone", "completion", "bash")
    #(bash_completion/"kubeone").write output

    # zsh completion
    #output = Utils.safe_popen_read("#{bin}/kubeone", "completion", "zsh")
    #(zsh_completion/"kubeone").write output
  end

  test do
    #system "#{bin}/kubeone", "version"
  end
end
