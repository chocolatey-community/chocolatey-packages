# [<img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/2bdf6f7e33ec1a8126829fbbc87b83e4473b3634/icons/apache-httpd.png" height="48" width="48" /> apache-httpd](https://chocolatey.org/packages/apache-httpd)

Apache HTTP Web Server for Windows.

## Note

This package will unzip the latest windows binary provided at Apache Haus (http://www.apachehaus.com/) with OpenSSL on Visual Studio 2012 (VC11):
with OpenSSL 1.0.2g, nghttp 1.9.2, Zlib 1.2.8 (mod_deflate), PCRE 8.38, APR 1.5.2, APR-Util 1.5.4, IPv6 and TLS SNI enabled

The complete path of the package will be ''%unzipLocation%\Apache24'' (default: C:\tools\Apache\httpd-2.4.25\Apache24).

A service with a given name is created with the default config location.

This package needs either a Java Runtime to run. The package has no dependencies to a java runtime to give a choice to install JRE, JDK or Server JRE.

## Parameters

The following package parameters can be set:

 * `/unzipLocation` - Unzip to a different destination folder. Default: C:\tools\Apache\httpd-2.4.25
 * `/serviceName` - The name of the windows service which will be create. Default: Apache

These parameters can be passed to the installer with the use of `-packageParameters `.
For example: choco install apache-httpd `-packageParameters '"/unzipLocation:C:\tools\Server /serviceName:Apache"'`.

## Install
