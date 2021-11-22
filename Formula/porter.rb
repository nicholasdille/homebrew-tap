class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.8",
    revision: "c1e1a04bb64353b9559c158f2cad6b2478225397"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.7"
    sha256 cellar: :any_skip_relocation, catalina:     "fcd490ae20f0f81730871a4e287b065e2119ca27941c73d5bbe1961c5b8f36ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "95ab8ae4e8813c1359a05cd93c83155a9c412dbfc049703295a44ad469248637"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "packr" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    system "make", "build-porter"
    bin.install "bin/porter"
  end

  test do
    system bin/"porter", "--version"
  end
end
