class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.35",
    revision: "a37cf84909e4d26c50224af9916145f7d9f67962"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.35"
    sha256 cellar: :any_skip_relocation, big_sur:      "56d5aca9be9be4e2052efb44e0f4c684a5fa749fe4028a93f76c9f13f8f83ae7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "916d87d1151f3a129148c55284d8f1e0c802df6fe67fd2ef7d78fd60730e989c"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/datreeio/datree"
    ENV["CGO_ENABLED"] = "0"

    system "go", "build",
      "-tags", "main",
      "-ldflags", "-X #{pkg}/cmd.CliVersion=#{version}",
      "-o", bin/"datree",
      "./main.go"
  end

  test do
    system bin/"datree", "version"
  end
end
