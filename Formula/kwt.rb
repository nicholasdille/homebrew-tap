class Kwt < Formula
  desc "Kubernetes Workstation Tools CLI"
  homepage "https://github.com/vmware-tanzu/carvel-kwt"

  url "https://github.com/vmware-tanzu/carvel-kwt.git",
    tag:      "v0.0.6",
    revision: "1f643fef4764445297e74e233df7562d13b5ac71"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kwt.git"

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
