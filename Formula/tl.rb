class Tl < Formula
  desc "Verify https assets with a public transparency log"
  homepage "https://www.transparencylog.com/"

  url "https://github.com/transparencylog/tl.git",
    tag:      "v0.2.12",
    revision: "4c2dc0ed57ea7629988b81cb6165fe179751c56b"
  license "Apache-2.0"
  head "https://github.com/transparencylog/tl.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/tl-0.2.12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "441fbad8f1280ca700a13766bae9183c98e124c7fc513058c087b273d720b5cf"
  end

  depends_on "go" => :build

  def install
    commit = Utils.git_short_head
    timestamp = Time.now.utc.iso8601
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X main.version=#{version}"\
                  " -X main.commit=#{commit}"\
                  " -X main.date=#{timestamp}",
      "-o", bin/"tl",
      "."
  end

  test do
    system bin/"tl", "version"
  end
end
