class Crane < Formula
  desc "Working with container registries"
  homepage "https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md"

  url "https://github.com/google/go-containerregistry.git",
    tag:      "v0.4.1",
    revision: "efb2d62d93a7705315b841d0544cb5b13565ff2a"
  license "Apache-2.0"
  head "https://github.com/google/go-containerregistry.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/crane-0.4.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1166acc99cec06a5371cf180e9dce849c8d676eed134a0da4d1dc25e1c694d39"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/google/go-containerregistry"
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w -X #{pkg}/cmd/crane/cmd.Version=#{version}",
      "-o", bin/"crane",
      "./cmd/crane"
  end

  test do
    system "#{bin}/crane", "version"
  end
end
