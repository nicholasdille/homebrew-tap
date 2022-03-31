class Mp3binder < Formula
  desc "Concatenating, joining, binding MP3 files without re-encoding"
  homepage "https://github.com/crra/mp3binder"

  url "https://github.com/crra/mp3binder.git",
    tag:      "5.0.0",
    revision: "7e69866e1463e1c99a1bf8d6d1b2018c4849145f"
  license "MIT"
  head "https://github.com/crra/mp3binder.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/mp3binder-5.0.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "b3355f4b8a3ee897f096142f1844cb7d5e378a9ae60ce709b09c274274e22e7d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4af73bddfa7ae3cac8ef0339e5ec1d1b5733bb70f43749e91a1bcb118974587f"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      "-trimpath",
      "-ldflags", "-w -s"\
                  " -X main.name=mp3binder"\
                  " -X main.version=#{version}"\
                  " -X main.realm=mp3binder"\
                  " -extldflags=-static",
      "-a",
      "-buildvcs=false",
      "-o", bin/"mp3binder",
      "./cmd/tui"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} --version")
  end
end
