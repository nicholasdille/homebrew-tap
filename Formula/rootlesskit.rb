class Rootlesskit < Formula
  desc "Linux-native fake root for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit.git",
    tag:      "v0.13.2",
    revision: "4d4817795ecea8dc976670cb27c105156d5ee5c0"
  license "Apache-2.0"
  revision 1
  head "https://github.com/rootless-containers/rootlesskit.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rootlesskit-0.13.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d36ccdb0a97e74aa9653da736ae2967f7d06ea4e050a2874f303c889ae11c4f"
  end

  depends_on "go" => :build

  def install
    system "make"

    bin.install "bin/rootlessctl"
    bin.install "bin/rootlesskit"
    bin.install "bin/rootlesskit-docker-proxy"
  end

  def caveats
    <<~EOS
      Make sure that newuidmap and newgidmap from the uidmap package are available.
    EOS
  end

  test do
    system "#{bin}/rootlesskit", "--version"
  end
end
