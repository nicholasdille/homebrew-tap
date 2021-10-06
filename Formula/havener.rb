class Havener < Formula
  desc "Swiss army knife for Kubernetes tasks"
  homepage "https://github.com/homeport/havener"

  url "https://github.com/homeport/havener.git",
    tag:      "v2.0.6",
    revision: "ca88c48304582ed8a7c8e96ea245ddd17fc45f75"
  license "MIT"
  head "https://github.com/homeport/havener.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w -extldflags -static"\
                  " -X github.com/homeport/havener/internal/cmd.version=#{version}",
      "-o", bin/"havener",
      "./cmd/havener/main.go"

    # bash completion
    output = Utils.safe_popen_read(bin/"havener", "completion", "bash")
    (bash_completion/"havener").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"havener", "completion", "fish")
    (zsh_completion/"havener.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"havener", "completion", "zsh")
    (zsh_completion/"_havener").write output
  end

  test do
    system bin/"havener", "version"
  end
end
