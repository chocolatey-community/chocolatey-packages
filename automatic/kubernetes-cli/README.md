# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@5a8c40781821bbd2746754b7ce723938090bb7c6/icons/kubernetes-cli.png" width="48" height="48"/> [kubernetes-cli](https://chocolatey.org/packages/kubernetes-cli)

## Production-Grade Container Orchestration

### Automated container deployment, scaling, and management

[Kubernetes](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes) is an open source system for managing
containerized applications across multiple hosts, providing basic mechanisms for deployment, maintenance, and scaling
of applications.

It groups containers that make up an application into logical units for easy management and discovery.  Kubernetes
builds upon [15 years of experience of running production workloads at Google](https://queue.acm.org/detail.cfm?id=2898444),
combined with best-of-breed ideas and practices from the community.

#### Planet Scale

Designed on the same principles that allows Google to run billions of containers a week, Kubernetes can scale without
increasing your ops team.

#### Never Outgrow

Whether testing locally or running a global enterprise, Kubernetes flexibility grows with you to deliver your
applications consistently and easily no matter how complex your need is.

#### Run K8s Anywhere

Kubernetes is open source giving you the freedom to take advantage of on-premises, hybrid, or public cloud
infrastructure, letting you effortlessly move workloads to where it matters to you.

### Features

#### [Automated rollouts and rollbacks](https://kubernetes.io/docs/concepts/workloads/controllers/deployment)

Kubernetes progressively rolls out changes to your application or its configuration, while monitoring application
health to ensure it doesn't kill all your instances at the same time. If something goes wrong, Kubernetes will rollback
the change for you. Take advantage of a growing ecosystem of deployment solutions.

#### [Storage Orchestration](https://kubernetes.io/docs/concepts/storage/persistent-volumes)

Automatically mount the storage system of your choice, whether from local storage, a public cloud provider such as
[GCP](https://cloud.google.com/storage) or [AWS](https://aws.amazon.com/products/storage), or a network storage system
such as NFS, iSCSI, Gluster, Ceph, Cinder, or Flocker.

#### [Automatic bin packing](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers)

Automatically places containers based on their resource requirements and other constraints, while not sacrificing
availability. Mix critical and best-effort workloads in order to drive up utilization and save even more resources.

#### [IPv4/IPv6 dual-stack](https://kubernetes.io/docs/concepts/services-networking/dual-stack)

Allocation of IPv4 and IPv6 addresses to Pods and Services.

#### [Self-healing](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#how-a-replicationcontroller-works)

Restarts containers that fail, replaces and reschedules containers when nodes die, kills containers that don't respond
to your user-defined health check, and doesn't advertise them to clients until they are ready to serve.

#### [Service discovery and load balancing](https://kubernetes.io/docs/concepts/services-networking/service)

No need to modify your application to use an unfamiliar service discovery mechanism. Kubernetes gives Pods their own IP
addresses and a single DNS name for a set of Pods, and can load-balance across them.

#### [Secret and configuration management](https://kubernetes.io/docs/concepts/configuration/secret)

Deploy and update secrets and application configuration without rebuilding your image and without exposing secrets in
your stack configuration.

#### [Batch execution](https://kubernetes.io/docs/concepts/workloads/controllers/job)

In addition to services, Kubernetes can manage your batch and CI workloads, replacing containers that fail, if desired.

#### [Horizontal scaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale)

Scale your application up and down with a simple command, with a UI, or automatically based on CPU usage.

#### [Designed for extensibility](https://kubernetes.io/docs/concepts/extend-kubernetes)

Add features to your Kubernetes cluster without changing upstream source code.
