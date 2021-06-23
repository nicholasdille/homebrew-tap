class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.20.0",
    revision: "eb87e4593affef6334e351886afde9b16d4efe85"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.20.0"
    sha256 cellar: :any_skip_relocation, catalina:     "bd811f19b7617f0715adf17bacec098f11b0849d71e5b4ed7320a59888f45ba0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "961577111913a3164a4937693e4d46105e306f4132f790aa1e27f27ca28a884f"
  end

  depends_on "go" => :build

  def install
    system "./hack/build.sh"
    bin.install "vendir"
  end

  test do
    system bin/"vendir", "version"
  end
end
