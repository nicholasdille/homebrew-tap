# Homebrew Tap with Container Formulae

I am using many tools from the container ecosystem for which no automated installation exists. I decided to create Homebrew formulae for them.

## How do I install these formulae?

`brew install nicholasdille/tap/<formula>`

Or `brew tap nicholasdille/tap` and then `brew install <formula>`.

## Formulae in this tap

Containers (Docker):

- buildkitd
- buildkitd-dockerfile
- buildx
- cni
- cni-isolation
- containerd
- distribution
- docker
- dockerd
- docker-app
- docker-compose v1 (binary formula)
- docker-compose v2
- docker-proxy
- docker-scan
- fuse-overlay (binary formula)
- fuse-overlay-snapshotter (binary formula)
- hub-tool
- manifest-tool
- nerdctl
- oci-image-tool
- oci-runtime-tool
- oras
- regclient
- rootlesskit
- runc
- slirp4netns
- stargz-snapshotter (binary formula)
- stargzify
- trivy

Containers (RedHat)

- bubblewrap
- buildah
- cni-dnsname
- conmon
- containers-common
- containers-image
- containers-storage
- crun
- podman
- podman-remote
- umoci

Rootless containers

- buildkitd-rootless
- containerd-rootless
- dockerd-rootless
- nerdctl-immortal

Kubernetes:

- clusterctl
- clusterawsadm
- cri-o
- crictl
- datree
- imgpkg
- kapp
- kbld
- kink
- kubectl-build
- kubeletctl
- kubeone
- kubescape
- kubeswitch
- kube-bench
- kustomizer
- kwt
- localizer
- loft (binary formula)
- sloop
- vcluster
- ytt

Formulae related to containers:

- bst ([PR #339](https://github.com/nicholasdille/homebrew-tap/pull/339))
- cntr
- containerssh
- cosign
- diun
- duffle
- faasd
- faasd-rootless
- firecracker
- firecracker-containerd
- firejail
- footloose
- gosu
- gvisor ([PR #177](https://github.com/nicholasdille/homebrew-tap/pull/177))
- ignite
- kata-containers
- kim
- norouter
- nydus ([PR #612](https://github.com/nicholasdille/homebrew-tap/pull/612))
- porter
- quark ([PR #211](https://github.com/nicholasdille/homebrew-tap/pull/211))
- rekor
- runq ([PR #353](https://github.com/nicholasdille/homebrew-tap/pull/353))
- sshocker
- stacker ([PR #606](https://github.com/nicholasdille/homebrew-tap/pull/606))
- su-exec
- sysbox
- tini
- uptodate
- yasu
- youki ([PR #609](https://github.com/nicholasdille/homebrew-tap/pull/609))
- zot

Formulae for useful tools:

- artifactory-cleanup
- bin
- chisel
- cloudflared
- criu ([PR #350](https://github.com/nicholasdille/homebrew-tap/pull/350))
- envcli
- envsub
- goss
- npiperelay (binary formula)
- patat / patat-bin
- promql
- reptyr
- semver-tool
- ssh-key-confirmer
- task
- tl
- trillian
- vendir

Formulae for fun:

- emojisum
- mp3binder

## Noteworthy formulae

- [Docker](https://formulae.brew.sh/formula/docker#default) (official)
- [act](https://formulae.brew.sh/formula/act#default) (official)
- [argocd](https://formulae.brew.sh/formula/argocd#default) (official)
- [cowsay](https://formulae.brew.sh/formula/cowsay#default) (official)
- [crane](https://formulae.brew.sh/formula/crane#default) (official)
- [doitlive](https://formulae.brew.sh/formula/doitlive#default) (official)
- [drone-cli](https://formulae.brew.sh/formula/drone-cli#default) (official)
- [earthly](https://formulae.brew.sh/formula/earthly#default) (official)
- [faas-cli](https://formulae.brew.sh/formula/faas-cli#default) (official)
- [figlet](https://formulae.brew.sh/formula/figlet#default) (official)
- [flarectl](https://formulae.brew.sh/formula/flarectl#default) (official)
- [fleet-cli](https://formulae.brew.sh/formula/fleet-cli#default) (official)
- [flux](https://formulae.brew.sh/formula/flux#default) (official)
- [fluxctl](https://formulae.brew.sh/formula/fluxctl#default) (official)
- [gh](https://formulae.brew.sh/formula/gh#default) (official)
- [gitlab-runner](https://formulae.brew.sh/formula/gitlab-runner#default) (official)
- [glab](https://formulae.brew.sh/formula/glab#default) (official)
- [govc](https://formulae.brew.sh/formula/govc#default) (official)
- [hcloud](https://formulae.brew.sh/hcloud/docker#default) (official)
- [havener](https://github.com/homeport/havener) (3rd party)
- [helm](https://formulae.brew.sh/formula/helm#default) (official)
- [hub](https://formulae.brew.sh/formula/hub#default) (official)
- [jfrog-cli](https://formulae.brew.sh/formula/jfrog-cli#default) (official)
- [k3d](https://formulae.brew.sh/formula/k3d#default) (official)
- [k3sup](https://formulae.brew.sh/formula/k3sup#default) (official)
- [kind](https://formulae.brew.sh/formula/kind#default) (official)
- [krew](https://formulae.brew.sh/formula/krew#default) (official)
- [kubeaudit](https://formulae.brew.sh/formula/kubeaudit#default) (official)
- [kubeconform](https://github.com/yannh/kubeconform) (3rd party)
- [kubernetes-cli (kubectl)](https://formulae.brew.sh/formula/kubernetes-cli#default) (official)
- [kustomize](https://formulae.brew.sh/formula/kustomize#default) (official)
- [lab](https://formulae.brew.sh/formula/lab#default) (official)
- [logcli](https://formulae.brew.sh/formula/logcli#default) (official)
- [lolcat](https://formulae.brew.sh/formula/lolcat#default) (official)
- [marp](https://formulae.brew.sh/formula/marp-cli#default) (official)
- [minikube](https://formulae.brew.sh/formula/minikube) (official)
- [mitmproxy](https://formulae.brew.sh/formula/mitmproxy#default) (official)
- [oras](https://formulae.brew.sh/formula/oras#default) (official)
- [pack](https://github.com/buildpacks/homebrew-tap/blob/main/Formula/pack.rb) (3rd party)
- [pluto](https://github.com/FairwindsOps/Pluto) (3rd party)
- [ponysay](https://formulae.brew.sh/formula/ponysay#default) (official)
- [powerline-go](https://formulae.brew.sh/formula/powerline-go#default) (official)
- [qrencode](https://formulae.brew.sh/formula/qrencode#default) (official)
- [shellcheck](https://formulae.brew.sh/formula/shellcheck#default) (official)
- [shellinabox](https://formulae.brew.sh/formula/shellinabox#default) (official)
- [singularity](https://formulae.brew.sh/formula/singularity#default) (official)
- [skopeo](https://formulae.brew.sh/formula/skopeo#default) (official)
- [socat](https://formulae.brew.sh/formula/socat#default) (official)
- [terrascan](https://formulae.brew.sh/formula/terrascan) (official)
- [toast](https://formulae.brew.sh/formula/toast#default) (official)
- [toilet](https://formulae.brew.sh/formula/toilet#default) (official)
- [tunnelto](https://github.com/agrinman/tunnelto) (3rd party)
- [yamllint](https://formulae.brew.sh/formula/yamllint#default) (official)
- [yq](https://formulae.brew.sh/formula/yq#default) (official)

## More about Homebrew

`brew help`, `man brew` or check the [Homebrew homepage](https://brew.sh).
