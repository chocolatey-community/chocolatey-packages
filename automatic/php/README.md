# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@4e147ce52b1a2a7ac522ffbce6d176f257de6ac1/icons/php.svg" width="48" height="48"/> [php](https://chocolatey.org/packages/php)

PHP is an HTML-embedded scripting language. Much of its syntax is borrowed from C, Java and Perl with a couple of unique PHP-specific features thrown in. The goal of the language is to allow web developers to write dynamically generated pages quickly.

This product includes PHP software, freely available from
     <http://www.php.net/software/>

## Package Parameters
- `/DontAddToPath` - Do not add install directory to path
- `/InstallDir`    - Override the installation directory (needs to be specified both during install and update, until it is remembered by choco)
- `/ThreadSafe`    - Install the thread safe version of php that is compatible with Apache.

These parameters can be passed to the installer with the use of --package-parameters.
For example: `choco install php --package-parameters='"/ThreadSafe ""/InstallDir:C:\PHP"""'`.

