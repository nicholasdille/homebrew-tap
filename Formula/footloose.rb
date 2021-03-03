class Footloose < Formula
  desc "Containers that look like Virtual Machines"
  homepage "https://github.com/weaveworks/footloose"

  url "https://github.com/weaveworks/footloose.git",
    tag:      "0.6.3",
    revision: "352435f62e04975f1aff08cfdc91241eaa163f36"
  license "Apache-2.0"
  head "https://github.com/weaveworks/footloose.git"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "mod", "vendor"
    system "go",
      "build",
      "-mod=vendor",
      "-ldflags", "-X main.version=#{version}",
      "-o",
      "#{bin}/footloose",
      "."
  end

  test do
    system "#{bin}/footloose", "version"
  end
end
