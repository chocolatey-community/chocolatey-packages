# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@2bdf6f7e33ec1a8126829fbbc87b83e4473b3634/icons/apache-httpd.png" width="48" height="48"/> [apache-httpd](https://chocolatey.org/packages/apache-httpd)

Apache HTTP Web Server for Windows.

The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards.

The Apache HTTP Server ("httpd") was launched in 1995 and it has been the most popular web server on the Internet since April 1996. It has celebrated its 20th birthday as a project in February 2015.

The Apache HTTP Server is a project of The Apache Software Foundation.

## Package Parameters

- `/installLocation` - Install to a different destination folder. Default: `$Env:AppData\Apache*`
- `/serviceName` - The name of the windows service which will be create. Default: `Apache`
- `/port` - The port Apache will listen to. Default: `8080`
- `/noService` - Don't install the apache httpd windows service

Example: `choco install apache-httpd --params '"/installLocation:C:\HTTPD /port:433"'`

## Notes

- This package will install the latest Apache binaries provided at Apache Lounge (https://www.apachelounge.com/) with 
    - openssl 3.1.2
    - nghttp2 1.52.0
    - jansson 2.14
    - curl 8.0.1
    - apr 1.7.3
    - apr-util 1.6.3
    - apr-iconv 1.2.2
    - zlib 1.2.13
    - brotli 1.0.9
    - pcre2 10.42
    - libxml2 2.10.3
    - lua VS17 5.4.4
    - expat 2.5.0
- The complete path of the package will be `$Env:AppData\Apache*`
- Apache will be installed as a service under the default name 'Apache' (can be disabled with the `/noService` install parameter)
