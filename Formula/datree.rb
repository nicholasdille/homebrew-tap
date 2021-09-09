class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.12.1",
    revision: "54c1ab75f2595ae49c0c4098182f6cd50aac7b1b"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.12.1"
    sha256 cellar: :any_skip_relocation, catalina:     "03b1ace32ff6e9d08778534ae7ab813f009f71246151a0f0c6388767daa30cdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "88cad3f316ff462ff09c8ebd011a22feaae9ae8b4113e1b1d87ea6e5ca6b21be"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/datreeio/datree"
    ENV["CGO_ENABLED"] = "0"

    system "go", "build",
      "-tags", "main",
      "-ldflags", "-X #{pkg}/cmd.CliVersion=#{version}",
      "-o", bin/"datree",
      "./main.go"
  end

  test do
    system bin/"datree", "version"
  end
end
