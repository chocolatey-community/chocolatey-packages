# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@8a042fbe6c07391d0c2da13f638b1fdde474850f/icons/sysinternals.png" width="48" height="48"/> [sysinternals](https://chocolatey.org/packages/sysinternals)


The Sysinternals Troubleshooting Utilities have been rolled up into a single suite of tools.
This file contains the individual troubleshooting tools and help files.
It does not contain non-troubleshooting tools like the BSOD Screen Saver or NotMyFault.

## Package parameters

- `/InstallDir` - Installation directory, by default Chocolatey tools directory.
- `/InstallationPath` - the same as `InstallDir`

Example: `choco install sysinternals --params "/InstallDir:C:\your\install\path"`

## Notes

- This package supports only latest version.
- This package by default installs to tools directory which will create shims for all applications. When you install to different directory, shims are not created but directory is added to the PATH.
- This package downloads the nano edition of sysinternals suite when installing it on a nano server.
- To have GUI for the tools, install [nirlauncher](https://chocolatey.org/packages/nirlauncher) package and use `/Sysinternals` package parameter.
- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**
