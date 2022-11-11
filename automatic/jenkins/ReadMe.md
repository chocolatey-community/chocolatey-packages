# ![Jenkins Logo](https://cdn.jsdelivr.net/gh/pauby/chocopackages@ae92e032839a27a3633db7018593b075df44269f/icons/jenkins.png "Jenkins Logo") [Jenkins](https://chocolatey.org/packages/jenkins)

This is the LTS version of Jenkins.

Jenkins is an open source automation server which enables developers around the world to reliably build, test, and deploy their software.

* Continuous Integration and Continuous Delivery
As an extensible automation server, Jenkins can be used as a simple CI server or turned into the continuous delivery hub for any project.

* Easy installation
Jenkins is a self-contained Java-based program, ready to run out-of-the-box, with packages for Windows, Mac OS X and other Unix-like operating systems.

* Easy configuration
Jenkins can be easily set up and configured via its web interface, which includes on-the-fly error checks and built-in help.

* Plugins
With hundreds of plugins in the Update Center, Jenkins integrates with practically every tool in the continuous integration and continuous delivery toolchain.

* Extensible
Jenkins can be extended via its plugin architecture, providing nearly infinite possibilities for what Jenkins can do.

* Distributed
Jenkins can easily distribute work across multiple machines, helping drive builds, tests and deployments across multiple platforms faster.

**NOTE**: You need Java JRE 11 for Jenkins to install. This has not been added as a dependency as there are so many flavours. The package used in testing was `termurin11jre` but others should work without issue. If the package cannot find a `JAVA_HOME` environment variable, or find a JRE folder in Program Files, the package will fail out. You can pass `JAVA_HOME` manually as follows:

`choco install jenkins --parameters="/JAVA_HOME='C:\Program Files\InstalledJRE\'"`

**NOTE**: This is an automatically updated package. If you find it is out of date by more than a week, please contact the maintainer(s) and let them know the package is no longer updating correctly.
