class Footloose < Formula
  desc "Containers that look like Virtual Machines"
  homepage "https://github.com/weaveworks/footloose"

  url "https://github.com/weaveworks/footloose.git",
    tag:      "0.6.3",
    revision: "352435f62e04975f1aff08cfdc91241eaa163f36"
  license "Apache-2.0"
  head "https://github.com/weaveworks/footloose.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/footloose-0.6.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "17992767273a40197a02dcce5d75bc47fadccbe0b0a772d3ba1781843ca3253d"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "mod", "vendor"
    system "go",
      "build",
      "-mod=vendor",
      "-ldflags", "-s -w -X main.version=#{version}",
      "-o", bin/"footloose",
      "."
  end

  test do
    system bin/"footloose", "version"
  end
end
