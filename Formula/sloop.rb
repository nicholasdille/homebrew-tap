class Sloop < Formula
  desc "Kubernetes History Visualization"
  homepage "https://github.com/salesforce/sloop"

  url "https://github.com/salesforce/sloop.git",
    tag:      "v1.1",
    revision: "e86b22215520900bf060e92c60c67da9ef97ef6c"
  license "Apache-2.0"
  head "https://github.com/salesforce/sloop.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sloop-1.1"
    sha256 cellar: :any_skip_relocation, catalina:     "88d72b55e4be4fff7c5d30fe3a85c5f9a263f5a7e4cc999f7145f162e4471b26"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7b471478977a966ec22f065ae05c64035f595274e03f241b630bbe2fd1c4a7f1"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s",
      "-o", bin/"sloop",
      "./pkg/sloop"
  end

  test do
    system "whereis", "sloop"
  end
end
