class Bin < Formula
  desc "Effortless binary manager"
  homepage "https://github.com/marcosnils/bin"

  url "https://github.com/marcosnils/bin.git",
    tag:      "v0.10.1",
    revision: "56ca9da13bdf966afeacfda6cf1979bb5ee1f64a"
  license "MIT"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bin-0.10.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "f72f707448c6345daa98c7a626a4f12edd5f0b49794dfcb17e40e1f0a41735dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "12ee3c87cc77a041253e6af92d5d083b498284b16e46c122e17423aaa71ce485"
  end

  depends_on "go" => :build

  def install
    commit = Utils.git_short_head
    build_date = Utils.safe_popen_read("date", "+%Y-%m-%dT%H:%M:%SZ")

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X main.version=#{version}"\
                  " -X main.commit=#{commit}"\
                  " -X main.date=#{build_date}"\
                  " -X main.builtBy=Homebrew",
      "-o",
      bin/"bin",
      "."
  end

  test do
    system bin/"bin", "--version"
  end
end
