# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@67c7262d5c8e065dcd8fffb320e7431333181ca6/icons/internetarchive.png" width="48" height="48"/> [internetarchive](https://chocolatey.org/packages/internetarchive)

`internetarchive` is a Python and command-line interface to [Archive.org](https://archive.org).

This package installs the `ia` command-line tool and the `internetarchive` Python
module in an isolated environment inside the Chocolatey package directory, using a
uv-managed Python interpreter. No system-wide Python installation is required.

## Features

* Search Archive.org and retrieve item metadata.
* Download and upload files, and modify item metadata.
* Access the `internetarchive` Python module programmatically.
* Fully isolated from any Python installation on the system.

## Usage

```powershell
ia --version
ia --help
ia search 'collection:nasa'
ia metadata nasa
```

## Notes

* This package requires 64-bit Windows.
* An internet connection is required during installation to download the
  managed Python interpreter and the `internetarchive` package.
* A uv-managed Python 3.12 interpreter is downloaded during installation.
* The `ia` command is added to the system `PATH`.
* The `uv` package is installed as a dependency and remains installed after
  this package is uninstalled.
* Uninstalling the package removes the managed Python interpreter and the
  virtual environment along with the rest of the package directory.

## License

AGPL-3.0. See the [project license](https://github.com/jjjake/internetarchive/blob/master/LICENSE).
