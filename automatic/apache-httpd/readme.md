# [<img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/2bdf6f7e33ec1a8126829fbbc87b83e4473b3634/icons/apache-httpd.png" height="48" width="48" /> apache-httpd](https://chocolatey.org/packages/apache-httpd)

Apache HTTP Web Server for Windows.

### Notes

This package will install the latest Apache binaries provided at
Apache Haus (http://www.apachehaus.com/) with OpenSSL on Visual Studio 2012 (VC11):
with OpenSSL 1.0.2g, nghttp 1.9.2, Zlib 1.2.8 (mod_deflate), PCRE 8.38, APR 1.5.2, APR-Util 1.5.4, IPv6 and TLS SNI enabled.

The complete path of the package will be ''%AppData%\Apache24''

Apache will be installed as a service under the default name 'Apache'

### Package Parameters

 * /installLocation - Intstall to a different destination folder. Default: %AppData%\Apache*
 * /serviceName - The name of the windows service which will be create. Default: Apache
 * /port - The port Apache will listen to. Default: 80
