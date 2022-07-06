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

  depends_on "go" => :build
  depends_on arch: :x86_64
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
    output = Utils.safe_popen_read({ "SHELL" => "fish" }, bin/"zot", "completion", "fish", { err: :err })
    (zsh_completion/"zot.fish").write output

    # zsh completion
    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"zot", "completion", "zsh", { err: :err })
    (zsh_completion/"_zot").write output
  end

  test do
    output = shell_output(bin/"zot --version 2>&1")
    assert_match version.to_s, output
  end
end
