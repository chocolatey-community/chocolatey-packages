# <img src="https://cdn.jsdelivr.net/gh/chocolatey/chocolatey-coreteampackages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/python.svg" width="48" height="48"/> [python2](https://chocolatey.org/packages/python2)


Python 2.x is a programming language that lets you work more quickly and integrate your systems more effectively. You can learn to use Python 2.x and see almost immediate gains in productivity and lower maintenance costs.

## Package Parameters

- `/InstallDir` - Installation directory

These parameters can be passed to the installer with the user of --params.
For example: `--params '"/InstallDir:C:\tools\python2"'`

## Notes

- This package installs the latest stable version of Python 2.x. It will install to Python 2.x to `$env:ChocolateyBinRoot\{{PackageName}}`, but only if Python 2.x is not already installed where the installer puts it by default, which is `$env:SystemDrive\PythonXX` (XX stands for the major/minor version digits).
- This package is not intended to use with Chocolatey's `-x86` parameter. If you want a 32-bit Python 2.x on 64-bit systems, install the [{{PackageName}}-x86_32](/packages/{{PackageName}}-x86_32) package instead. You can also install both packages. In this case you must manually adapt your PATH environment variable so that it picks the Python 2.x version that you want when invoking `python.exe`.

