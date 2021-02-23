class DockerComposeCli < Formula
    desc "Easily run your Compose application to the cloud with compose-cli"
    homepage "https://github.com/docker/compose-cli"
  
    url "https://github.com/docker/compose-cli.git",
      tag:      "v1.0.7",
      revision: "4a4e6be1cbf9fa1b5a5935f0676e87a50ca66e23"
    license "Apache-2.0"
  
    depends_on "go" => :build
  
    def install
      system "make", "-f", "builder.Makefile", "cross"
      bin.install "bin/docker-linux-amd64" => "compose-cli"

      # TODO: Docker CLI plugin wrapper
    end
  
    test do
      # TODO: Test
    end
  end
  