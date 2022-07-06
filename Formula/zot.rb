class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.4.1",
    revision: "620bc7c517dc9c5c41e918f7c6bf8026633fd6cf"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "befe1eb28a01f25a5be91bdf26388d84e593113854355f291a203b2c223a160a"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    system "make", "binary"
    bin.install "bin/zot-linux-amd64" => "zot"
  end

  def post_install
    # bash completion
    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"zot", "completion", "bash", { err: :err })
    (bash_completion/"zot").write output

    # fish completion
    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"zot", "completion", "fish", { err: :err })
    (zsh_completion/"zot.fish").write output

    # zsh completion
    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"zot", "completion", "zsh", { err: :err })
    (zsh_completion/"_zot").write output
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} --version")
  end
end
