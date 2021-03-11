class Tl < Formula
  desc "Verify https assets with a public transparency log"
  homepage "https://www.transparencylog.com/"

  url "https://github.com/transparencylog/tl.git",
    tag:      "v0.2.12",
    revision: "4c2dc0ed57ea7629988b81cb6165fe179751c56b"
  license "Apache-2.0"
  head "https://github.com/transparencylog/tl.git"

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
