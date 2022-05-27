class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.41.1",
    revision: "2a58cd709ad3e7a02383de32bbb7d31431f028fd"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.41.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7ded2a19e7253c9c5a01f11cd12ad1ec410a4293718529194d86b0887c140db9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7eeae0af6a454180dfc953aee5372ce5559711b139ca2fe3af89bc3178b2911e"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", bin/"ytt",
      "./cmd/ytt"
  end

  test do
    system bin/"ytt", "--version"
  end
end
