# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/python.svg" width="48" height="48"/> [python3](https://chocolatey.org/packages/python3)


Python 3.x is a programming language that lets you work more quickly and integrate your systems more effectively. You can learn to use Python 3.x and see almost immediate gains in productivity and lower maintenance costs.

## Package Parameters

- `/InstallDir` - Installation directory

These parameters can be passed to the installer with the user of --params.
For example: `--params '"/InstallDir:C:\tools\python2"'`

## Notes

- This package installs the latest stable version of Python 3.x. It will install to Python 3.x to C:\Python3x.
- This package is not intended to use with Chocolatey's `-x86` parameter. If you want a 32-bit Python 3.x on 64-bit systems, install the [{{PackageName}}-x86_32](/packages/{{PackageName}}-x86_32) package instead. You can also install both. In that case you must manually adapt your .exe shims so that it picks the desired version when you invoke `python.exe`.

