class Envsub < Formula
  desc "Alternative envsubst that allows for ${foo:-default} expansion too"
  homepage "https://github.com/stephenc/envsub"

  url "https://github.com/stephenc/envsub.git",
    tag:      "0.1.3",
    revision: "605623d4224986e0028e2dec9055891c2c46bfd6"
  license "Apache-2.0"
  head "https://github.com/stephenc/envsub.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "make" => :build
  depends_on "rust" => :build
  depends_on :linux

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/envsub --version")
  end
end
