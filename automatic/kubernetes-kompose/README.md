# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@e4e529ccc804ac6fac259a658e395e38b42b24f3/icons/kubernetes-kompose.png" width="48" height="48"/> [kubernetes-kompose](https://chocolatey.org/packages/kubernetes-kompose)

## Kubernetes + Compose = Kompose

`kompose` is a tool to help users who are familiar with `docker-compose` move to container orchestrators such as
[Kubernetes](https://kubernetes.io) or [Openshift](https://www.redhat.com/en/technologies/cloud-computing/openshift).
`kompose` takes a Docker Compose file and translates it into Kubernetes resources.

`kompose` is a convenience tool to go from local Docker development to managing your application with Kubernetes.
Transformation of the Docker Compose format to Kubernetes resources manifest may not be exact, but it helps
tremendously when first deploying an application on Kubernetes.

### Features

* Simplify your development process with Docker Compose and then deploy your containers to a production cluster
* Convert your docker-compose.yaml with one simple command `kompose convert`
* Immediately bring up your cluster with `kompose up`
* Bring it back down with `kompose down`

#### Note: Windows support is limited to 64bit systems
