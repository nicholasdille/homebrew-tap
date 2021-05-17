# Homebrew Tap with Container Formulae

I am using many tools from the container ecosystem for which no automated installation exists. I decided to create Homebrew formulae for them.

## How do I install these formulae?

`brew install nicholasdille/tap/<formula>`

Or `brew tap nicholasdille/tap` and then `brew install <formula>`.

## Formulae in this tap

Containers (Docker):

- dockerd
- containerd
- runc
- buildkitd
- nerdctl
- docker-compose-cli
- buildx
- cni
- cni-isolation
- distribution
- docker-app
- docker-compose (binary formula)
- docker-scan
- fuse-overlay (binary formula)
- fuse-overlay-snapshotter
- hub-tool
- manifest-tool
- oci-image-tool
- oci-runtime-tool
- oras
- regclient
- rootlesskit
- slirp4netns
- stargz-snapshotter (binary formula)
- stargzify
- trivy

Containers (RedHat)

- bubblewrap
- buildah
- conmon
- containers-storage
- podman
- umoci

Rootless containers

- dockerd-rootless
- containerd-rootless
- buildkitd-rootless
- nerdctl-immortal

Kubernetes:

- clusterctl
- clusterawsadm
- cri-o
- crictl
- imgpkg
- kapp
- kbld
- kubectl-build
- kubeone
- kubeswitch
- kwt
- localizer
- vcluster
- ytt

Formulae related to containers:

- containerssh
- cosign
- duffle
- faasd
- faasd-rootless
- firecracker
- footloose
- ignite
- kim
- norouter
- porter
- rekor
- sshocker
- sysbox
- task
- tl
- vendir

Formulae for run:

- emojisum

## Noteworthy formulae

- [Docker](https://formulae.brew.sh/formula/docker#default) (official)
- act
- argocd
- cowsay
- crane
- drone-cli
- earthly
- faas-cli
- figlet
- flarectl
- fleet-cli
- flux
- fluxctl
- gh
- gitlab-runner
- glab
- govc
- hcloud
- helm
- hub
- jfrog-cli
- k3d
- k3sup
- krew
- kubernetes-cli (kubectl)
- kustomize
- lab
- mitmproxy
- oras
- pack (3rd party)
- ponysay
- powerline-go
- qrencode
- shellcheck
- shellinabox
- singularity
- skopeo
- socat
- toast
- toilet
- yamllint
- yq

## More about Homebrew

`brew help`, `man brew` or check the [Homebrew homepage](https://brew.sh).
