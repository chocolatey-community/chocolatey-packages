# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@0d3be7b221c8110f562a0059a8818238a1cb46ec/icons/minikube.png" width="48" height="48"/> [minikube](https://chocolatey.org/packages/minikube)

Minikube implements a local Kubernetes cluster. Minikube's [primary goals](https://minikube.sigs.k8s.io/docs/contrib/principles)
are to be the best tool for local Kubernetes application development and to support all Kubernetes features that fit.

### Minikube Features

Minikube runs the latest stable release of Kubernetes, with support for standard Kubernetes features like:

* [LoadBalancer](https://minikube.sigs.k8s.io/docs/handbook/accessing/#loadbalancer-access) - using `minikube tunnel`
* Multi-cluster - using `minikube start -p <name>`
* NodePorts - using `minikube service`
* [Persistent Volumes](https://minikube.sigs.k8s.io/docs/handbook/persistent_volumes)
* [Ingress](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube)
* [Dashboard](https://minikube.sigs.k8s.io/docs/handbook/dashboard) - `minikube dashboard`
* [Container runtimes](https://minikube.sigs.k8s.io/docs/handbook/config/#runtime-configuration) - `start --container-runtime`
* [Configure apiserver and kubelet options](https://minikube.sigs.k8s.io/docs/handbook/config/#modifying-kubernetes-defaults) via command-line flags

As well as developer-friendly features:

* [Addons](https://minikube.sigs.k8s.io/docs/handbook/deploying/#addons) - a marketplace for developers to share configurations for running services on minikube
* [NVIDIA GPU support](https://minikube.sigs.k8s.io/docs/tutorials/nvidia_gpu/) - for machine learning
* [Filesystem mounts](https://minikube.sigs.k8s.io/docs/handbook/mount/)

#### Note: Windows support is limited to 64bit systems
