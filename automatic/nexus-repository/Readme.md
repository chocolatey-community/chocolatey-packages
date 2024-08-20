# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@f459e946d7b1926ee89c2b415ec8507dffe99218/icons/nexus-repository.png" width="48" height="48"/> [Nexus Repository OSS](https://chocolatey.org/packages/nexus-repository)

Free open source version of popular Nexus Repository for binary artifacts including first class Nuget support.

## Features

Free OSS version supports advanced access control (groups, roles), LDAP and per-user api keys.
Nexus product does not have a built-in web gallery for components.

* Build quickly and reliably:  
  Publish and cache components in a central repository that connects natively to all popular package managers.
* Manage storage space efficiently:  
  Automatically clean up old or unused artifacts from your repositories
* Assess open source risk:  
  Centralize your consumption of open source to gain insight into the risk in your software supply chain.
* Block malicious components:  
  Add Nexus Firewall to stop OSS risk from entering your SDLC using next-generation behavioral analysis and automated policy enforcement.
* Flexible security:  
  Control access to your components with role-based access controls and full auditability.

## Package Parameters

This package supports the following parameters:

* `/Fqdn` - The fqdn that matches the subject you are using for your Nexus instance SSL certificate.
* `/Port` - Specify what port Nexus should listen on. Defaults to `8081`.
* `/BackupSslConfig` - Ensures that the ssl configuration survives an upgrade.
* `/BackupLocation` - Species the path to backup ssl configuration to during upgrade. Defaults to `~/NexusSSLBackup`.

You can pass parameters as follows:

`choco install nexus-repository --parameters="/Fqdn='nexus.example.com' /Port=4443 /BackupSslConfig /BackupLocation='X:\Backup\NexusSSL'"`

## Notes

- **ATTENTION BREAKING CHANGE FOR UPGRADES FROM VERSIONS BEFORE 3.71.0.6**  
    Nexus has upgraded the bundled version of Java, and sunset the OrientDb database type.
    This means that you will need to migrate your database from OrientDb, if you are using it.
    See [here](https://help.sonatype.com/en/orient-3-70-java-8-or-11.html) for further details,
    or check out the nexus-repository-migrator package.

- **ATTENTION BREAKING CHANGE FOR UPGRADES FROM VERSIONS BEFORE 3.3.2.02**  
    Nexus no longer provided a setup.exe for installing Nexus Repository 3.x on Windows.
    If you previously installed this with a package that used a setup.exe, you must manually uninstall it first (use choco uninstall nexus-repository if you used Chocolatey to install it).    Once you are on 3.3.2.02 or later, upgrades will work smoothly.
