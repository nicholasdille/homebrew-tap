class Kwt < Formula
  desc "Kubernetes Workstation Tools CLI"
  homepage "https://github.com/vmware-tanzu/carvel-kwt"

  url "https://github.com/vmware-tanzu/carvel-kwt.git",
    tag:      "v0.0.6",
    revision: "1f643fef4764445297e74e233df7562d13b5ac71"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kwt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kwt-0.0.6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e3498c11cee3551778877ec80cd75536d447623abd842b8054f664c136cb16e3"
  end

  depends_on "go" => :build

  def install
    dir = buildpath/"src/github.com/k14s/kwt"
    dir.install (buildpath/"").children
    cd dir do
      ENV["CGO_ENABLED"] = "0"
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      system "go",
        "build",
        "-ldflags", "-s -w",
        "-o", bin/"kwt",
        "./cmd/kwt"
    end
  end

  test do
    system bin/"kwt", "version"
  end
end
