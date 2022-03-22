class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.10",
    revision: "55d92c0f283c1e234a8477ad9d49a5e8c3f08107"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.9"
    sha256 cellar: :any_skip_relocation, big_sur:      "ddd072370f6facf2fcacbd036d2dde54e4ab3ccda23aadca29b5a36db9828bd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5c85d51e780107e71700d9ecfa222370e59f74cc252f584edc3ff4e971a7a626"
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
