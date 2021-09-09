class Sloop < Formula
  desc "Kubernetes History Visualization"
  homepage "https://github.com/salesforce/sloop"

  url "https://github.com/salesforce/sloop.git",
    tag:      "v1.1",
    revision: "e86b22215520900bf060e92c60c67da9ef97ef6c"
  license "Apache-2.0"
  head "https://github.com/salesforce/sloop.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s",
      "-o", bin/"sloop",
      "./pkg/sloop"
  end

  test do
    system "whereis", "sloop"
  end
end
