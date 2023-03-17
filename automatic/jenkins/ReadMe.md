# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@c50597be672d029c1628f0a67b6e7a3775d511ce/icons/jenkins.png" width="48" height="48"/> [Jenkins](https://chocolatey.org/packages/jenkins)

This is the LTS version of Jenkins.

Jenkins is an open source automation server which enables developers around the world to reliably build, test, and deploy their software.

## Features

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

## Package Parameters

* `/InstallDir` - The directory to install Jenkins to. Defaults to `C:\Program Files\Jenkins`
* `/Jenkins_Root` - The directory to store data in. Defaults to `C:\ProgramData\Jenkins`
* `/Port` - The port to access Jenkins via. Defaults to `8080`.
* `/Java_Home` - The path to an installation of JRE 11, if not present in `$env:JAVA_HOME`.
* `/Service_Username` - The account to run the Jenkins service as. Defaults to `localsystem`.
* `/Service_Password` - The account password to use to authenticate.

You can pass parameters as follows:

`choco install jenkins --parameters="/JAVA_HOME='C:\Program Files\InstalledJRE\' /PORT=8081"`

## Notes

* **NOTE**: You need Java JRE 11 for Jenkins to install. This has not been added as a dependency as there are so many flavours. The package used in testing was `temurin11jre` but others should work without issue. If the package cannot find a `JAVA_HOME` environment variable, or find a JRE folder in Program Files, the package will fail out.
* **NOTE**: This is an automatically updated package. If you find it is out of date by more than a week, please contact the maintainer(s) and let them know the package is no longer updating correctly.
