# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@f7ae3543e4bce2cbb3525fe2ada977031e43781c/icons/composer.png" width="48" height="48"/> [composer](https://chocolatey.org/packages/composer)

Composer Setup downloads and installs the latest version of Composer, the PHP Dependency Manager, so you can use it easily from the command line.

## Features

 * Composer is installed globally - just type `composer` from any location to use it.
 * Works from cmd, Git Bash, Msys2 and Cygwin terminals.
 * Modifies php.ini, if required.

## Package Parameters

The following parameters are generally intended for CI usage:

* `/Dev:path` - this installs Composer to the specified path, but without an uninstaller.
* `/Php:folder-or-exe` - this uses PHP from the specified location, adding it to the path.

Use the `--params` option to pass them to the installer.
For example: `--params '"/Dev:C:\tools\composer /Php:C:\php"'`.

## Notes

The version number refers to the Composer Setup installer and not to Composer, which you can update by running `composer self-update` from your terminal.

This package has a dependency on the Chocolatey PHP package. If this is not found, the latest version will be downloaded and installed first.

If you encounter any problems with the installation, you can run it interactively using the `--notsilent` option.
