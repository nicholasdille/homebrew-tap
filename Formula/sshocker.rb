class Sshocker < Formula
  desc "ssh + reverse sshfs + port forwarder, in Docker-like CLI"
  homepage "https://github.com/AkihiroSuda/sshocker"

  url "https://github.com/AkihiroSuda/sshocker.git",
    tag:      "v0.1.0",
    revision: "006b942173f1d9511a9cb1eb9d5ee97e7352b5a0"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/sshocker.git"

  depends_on "go" => :build

  def install
    system "make"

    bin.install "bin/sshocker"
  end

  test do
    system "#{bin}/sshocker", "--version"
  end
end
