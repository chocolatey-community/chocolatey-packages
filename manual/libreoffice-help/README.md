# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/libreoffice.svg" width="48" height="48"/> [libreoffice-help](https://chocolatey.org/packages/libreoffice-help)

**NOTE: THIS PACKAGE IS NOT MAINTAINED. See https://github.com/chocolatey/chocolatey-coreteampackages/issues/762**

This package installs the help pack for LibreOffice, the free and open source office suite.

It installs the LibreOffice Help Pack in the first language which matches this list:

1. Install arguments override parameter if present, e.g. `choco install libreoffice-help -installArgs l=es`
To get a list of all available locales have a look at this folder: http://download.documentfoundation.org/libreoffice/stable/{{PackageVersion}}/win/x86/
2. If libreoffice-help is already installed: the same language as the already installed libreoffice-help. If more than one LibreOffice Help Packs are already installed, this package updates all of them.
3. The Windows language of the current user account.
4. If libreoffice-help is not available in one of the previous languages, it defaults to `en-US`.
It is also possible to install multiple Help Packs. To achieve that, install them like this: `choco install libreoffice-help -force -installArgs l=<languageCode>`

