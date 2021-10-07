class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.37.0",
    revision: "4cb1eb86f263e2c6e5290a7a111dddd2c67ca78e"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.37.0"
    sha256 cellar: :any_skip_relocation, catalina:     "7920b4fcc91b1b58676ea3365a8c9ca5af65a8b86df35b461afc8e3ae075dd16"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0b1841932d6b9c878ddd27f48316809dd5252d834a09af91730d1aaa39385c9d"
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
