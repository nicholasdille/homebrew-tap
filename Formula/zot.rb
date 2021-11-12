class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.2",
    revision: "8e4d8288677a0fed78a27c1756a22e9b73737f2e"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.1"
    sha256 cellar: :any_skip_relocation, catalina:     "872b6a102cfa71968bc7d53272e7f0ae53393d99b37a1a03c593884545452a66"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a92ef324735c0f1427426ae9607d568c3cc8e5f000e74343390010a924d754a0"
  end

  depends_on "go" => :build

  def install
    system "make", "binary"
    bin.install "bin/zot"
  end

  test do
    system bin/"zot", "--version"
  end
end
