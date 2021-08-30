class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.2.8",
    revision: "c6670b13295ffe69bcab59c655d5b02e2c13b9ab"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.2.8"
    sha256 cellar: :any_skip_relocation, catalina:     "afb934529431da5d45e64c7343ac0600211dce92db4ff4e70357ba2d7f7bda7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ff1ff4f180907a8e83b2cf842a074d68a44e538fd5266f3e2fd47956800c92d8"
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
