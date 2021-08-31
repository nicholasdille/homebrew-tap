class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v1.0.55",
    revision: "f069955231fae552bd48409c233676439053b9a4"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-1.0.52-beta"
    sha256 cellar: :any_skip_relocation, catalina:     "3c539bb0541458b61ae6dd9232785ea86886dc10e8a1c72f11b043283c3b676a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0493b8e68cf433bd4d051d81d7a8fc69f57e859e6fb47a7d34aaaa9f6433141c"
  end

  depends_on "go" => :build

  def install
    system "go",
      "mod",
      "tidy"

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o",
      bin/"kubescape",
      "."
  end

  test do
    system "whereis", "kubescape"
  end
end
