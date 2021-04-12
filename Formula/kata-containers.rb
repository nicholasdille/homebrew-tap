class KataContainers < Formula
  desc "Lightweight Virtual Machines (VMs) that feel and perform like containers"
  homepage "https://katacontainers.io/"

  url "https://github.com/kata-containers/kata-containers.git",
    tag:      "2.0.3",
    revision: "ef11ce13ea2f93c24ab04032c9c445611165d1ae"
  license "Apache-2.0"
  head "https://github.com/kata-containers/kata-containers.git"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "rust" => :build
  depends_on "gcc" => :build

  def install
    dir = buildpath/"src/github.com/kata-containers/kata-containers"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GOPATH"] = buildpath
      #https://github.com/kata-containers/kata-containers/blob/main/docs/Developer-Guide.md#initial-setup
      system "make"
      #kata-runtime
      #containerd-shim-kata-v2
      #configuration.toml
    end
  end

  test do
    #
  end
end
