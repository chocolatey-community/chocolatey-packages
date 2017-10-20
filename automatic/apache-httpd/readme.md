# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/2bdf6f7e33ec1a8126829fbbc87b83e4473b3634/icons/apache-httpd.png" width="48" height="48"/> [apache-httpd](https://chocolatey.org/packages/apache-httpd)


Apache HTTP Web Server for Windows.

The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards.

The Apache HTTP Server ("httpd") was launched in 1995 and it has been the most popular web server on the Internet since April 1996. It has celebrated its 20th birthday as a project in February 2015.

The Apache HTTP Server is a project of The Apache Software Foundation.

## Package Parameters

* `/installLocation` - Intstall to a different destination folder. Default: `$Env:AppData\Apache*`
* `/serviceName` - The name of the windows service which will be create. Default: `Apache`
* `/port` - The port Apache will listen to. Default: `80`

Example: `choco install apache-httpd --params '"/installLocation:C:\HTTPD /port:433"'`

## Notes

* This package will install the latest Apache binaries provided at Apache Haus (http://www.apachehaus.com/) with OpenSSL on Visual Studio 2012 (VC11): with OpenSSL 1.0.2g, nghttp 1.9.2, Zlib 1.2.8 (mod_deflate), PCRE 8.38, APR 1.5.2, APR-Util 1.5.4, IPv6 and TLS SNI enabled.
* The complete path of the package will be `$Env:AppData\Apache*`
* Apache will be installed as a service under the default name 'Apache'

