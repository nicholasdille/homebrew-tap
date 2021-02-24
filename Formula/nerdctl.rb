class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/AkihiroSuda/nerdctl"

  url "https://github.com/AkihiroSuda/nerdctl.git",
    tag:      "v0.6.1",
    revision: "7399297823f1d5745929d1e458c9da0d49c9e079"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.6.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "60aa76b4a72e9f9391edae25adff104747d902a6e60c56a5df7db2cf385db526"
  end

  depends_on "go" => :build
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/buildkitd" => :recommended
  depends_on "nicholasdille/tap/cni" => :recommended
  depends_on "nicholasdille/tap/cni-isolation" => :recommended

  def install
    system "make"
    bin.install "_output/nerdctl"
    (var/"lib/nerdctl").mkpath
  end

  test do
    ENV["XDG_RUNTIME_DIR"] = var/"lib/nerdctl"
    system "#{bin}/nerdctl", "--version"
  end
end
