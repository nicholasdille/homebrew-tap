class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.45.0",
    revision: "edeb9dd9a923e15187f88999e983cb5762a14faa"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kapp.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.44.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "37d9c511c8e664472c24feceba6e6b81b9fdb0bddeff0177e6ccdab1c050c0c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7c6501683c93173e96f8383620e1d2c50b618e1f4d8382008edfa572043357d9"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", bin/"kapp",
      "./cmd/kapp"

    # bash completion
    output = Utils.safe_popen_read(bin/"kapp", "completion", "bash")
    (bash_completion/"kapp").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"kapp", "completion", "fish")
    (fish_completion/"kapp.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"kapp", "completion", "zsh")
    (zsh_completion/"_kapp").write output
  end

  test do
    system bin/"kapp", "--version"
  end
end
