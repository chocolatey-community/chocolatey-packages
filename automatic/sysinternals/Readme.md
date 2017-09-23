# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/8a042fbe6c07391d0c2da13f638b1fdde474850f/icons/sysinternals.png" width="48" height="48"/> [sysinternals](https://chocolatey.org/packages/sysinternals)


The Sysinternals Troubleshooting Utilities have been rolled up into a single suite of tools.
This file contains the individual troubleshooting tools and help files.
It does not contain non-troubleshooting tools like the BSOD Screen Saver or NotMyFault.

## Package parameters

- `/InstallDir` - Installation directory, by default Chocolatey tools directory.
- `/InstallationPath` - the same as `InstallDir`

## Notes

- This package by default installs to tools directory which will create shims for all applications. When you install to different directory, shims are not created but directory is added to the PATH.
- This package now downloads the nano edition of sysinternals on nano servers.

