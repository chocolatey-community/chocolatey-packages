# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/e5fb8d88f655ec82c1b56702686d9627cfc3ac2e/icons/nssm.png" width="48" height="48"/> [nssm](https://chocolatey.org/packages/nssm)

nssm is a service helper which doesn't suck. srvany and other service helper programs suck because they don't handle failure of the application running as a service. If you use such a program you may see a service listed as started when in fact the application has died. nssm monitors the running service and will restart it if it dies. With nssm you know that if a service says it's running, it really is. Alternatively, if your application is well-behaved you can configure nssm to absolve all responsibility for restarting it and let Windows take care of recovery actions.

nssm logs its progress to the system Event Log so you can get some idea of why an application isn't behaving as it should.

## Features

* GUI and CLI interface
* Configurable action when application exits: restart, ignore, exit, suicide
* Manage native services
* Rotate output files from the monitored application
* Set the monitored application's priority class and CPU affinity
* UAC aware
* Unicode support
* Works under Windows 2000 or later. Specifically, Windows 7, Windows 8 and Windows 10 are supported, x32 and x64 bit versions.

