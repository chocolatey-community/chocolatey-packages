# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/python.svg" width="48" height="48"/> [python3](https://chocolatey.org/packages/python3)

Python 3.x is a programming language that lets you work more quickly and integrate your systems more effectively. You can learn to use Python 3.x and see almost immediate gains in productivity and lower maintenance costs.

## Package Parameters

- `/InstallDir` - Installation directory. **NOTE**: If you have pre-existing python3 installation, this parameter is ignored and existing python install location will be used
- `/InstallDir32:` - Installation directory for 32bit python on 64bit Operating Systems. **NOTE**: Do only use this parameter if you wish to install 32bit python alongside 64bit python. 32Bit python will not be added on PATH.

Example: `choco install python3 --params "/InstallDir:C:\your\install\path"`

## Notes

- Python package manager `pip` is installed by default, but you can also invoke it using command `py -m pip` which will use `pip3` and adequate version of python if you also have python2 installed and/or pip2 on the `PATH`. For more details see [Python on Windows FAQ](https://docs.python.org/3/faq/windows.html).
- For complete list of silent install options see the [Installing Without UI](https://docs.python.org/3/using/windows.html#installing-without-ui) page.
- Some packages require working C++ SDK to build C-based Python modules. One way to do so is to install [visualstudio2019-workload-vctools](https://chocolatey.org/packages/visualstudio2019-workload-vctools). See [GitHub issue #1518](https://github.com/chocolatey-community/chocolatey-coreteampackages/issues/1518) for more details.
