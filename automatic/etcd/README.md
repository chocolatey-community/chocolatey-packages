# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@c681fe2d8274d648911c90a5cfa63b43e4663013/icons/etcd.png" width="48" height="48"/> [etcd](https://chocolatey.org/packages/etcd)

**etcd** is a strongly consistent, distributed key-value store that provides a reliable way to store data that needs to
be accessed by a distributed system or cluster of machines. It gracefully handles leader elections during network
partitions and can tolerate machine failure, even in the leader node.

## Features

* **Simple interface** Read and write values using standard HTTP tools, such as curl
* **Key-value storage** Store data in hierarchically organized directories, as in a standard filesystem
* **Watch for changes** Watch specific keys or directories for changes and react to changes in values
* Optional SSL client certificate authentication
* Benchmarked at 1000s of writes/s per instance
* Optional TTLs for keys expiration
* Properly distributed via Raft protocol  

## Package Parameters

* The package will pass package parameters to the etcd service  
Example: `choco install etcd -y --params="-discovery https://discovery.etcd.io/tokengoeshere"`

## Notes

* This package installs **etcd** as a service, and makes **etcdctl** (the command line client) available in the path
* The service is managed with NSSM, you can change the service parameters easily by running `nssm edit etcd`
* Windows support is limited to 64-bit systems
* Originally packaged by Robert Labrie (https://github.com/robertlabrie)
