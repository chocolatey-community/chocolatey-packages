# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/c681fe2d8274d648911c90a5cfa63b43e4663013/icons/etcd.png" width="48" height="48"/> [etcd](https://chocolatey.org/packages/etcd)

etcd is a distributed reliable key-value store for the most critical data of a distributed system, with a focus on being:
  * _Simple_: well-defined, user-facing API (gRPC)
  * _Secure_: automatic TLS with optional client cert authentication
  * _Fast_: benchmarked 10,000 writes/sec
  * _Reliable_: properly distributed using Raft

etcd is written in Go and uses the Raft consensus algorithm to manage a highly-available replicated log.

etcd is used in production by many companies, and the development team stands behind it in critical deployment scenarios, where etcd is frequently teamed with applications such as Kubernetes, locksmith, vulcand, Doorman, and many others. Reliability is further ensured by rigorous testing.

This package installs **etcd** as a service, and makes **etcdctl** (the command line client) available in the path.

The package will pass package parameters to the etcd service.
Example: `choco install etcd -y --params="-discovery https://discovery.etcd.io/tokengoeshere"`

The service is managed with NSSM, you can change the service parameters easily by running `nssm edit etcd`

Originally packaged by Robert Labrie (https://github.com/tnwinc/chocolatey-etcd)

#### Note: Windows support is limited to 64bit systems.
