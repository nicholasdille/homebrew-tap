class Dockerd < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://github.com/moby/moby.git",
    tag:      "v20.10.5",
    revision: "363e9a88a11be517d9e8c65c998ff56f774eb4dc"
  license "Apache-2.0"
  revision 1
  head "https://github.com/moby/moby.git"

  depends_on "git" => :build
  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/runc"

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["GO111MODULE"] = "auto"

    system "make", "binary", "VERSION=#{version}"

    bin.install "bundles/binary-daemon/dockerd-#{version}" => "dockerd"
    bin.install "bundles/binary-daemon/docker-proxy"
    bin.install "bundles/binary-daemon/docker-init"
    bin.install "contrib/dockerd-rootless.sh"

    (buildpath/"daemon.json").write <<~EOS
      {
        "features": {
          "buildkit": true
        }
      }
    EOS
    (etc/"docker").install "daemon.json"
  end

  test do
    system "#{bin}/dockerd", "--version"
  end
end
