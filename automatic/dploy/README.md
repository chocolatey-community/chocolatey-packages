# [dploy](https://chocolatey.org/packages/dploy)

`dploy` is a tool for creating symbolic links similarly to [GNU Stow](https://www.gnu.org/software/stow/). It is provided as a CLI tool and a Python 3.10+ module and supports Windows, Linux, and OSX.

The `stow` command creates symbolic links to the contents of packages in a specified destination directory. Repeating the `stow` command with the same arguments confirms that the contents of the package have been symbolically linked. The `unstow` command removes symbolic links that resulted from `stow` commands.

This package installs the `dploy` command-line tool and the `dploy` Python module in an isolated environment inside the Chocolatey package directory, using a uv-managed Python interpreter. No system-wide Python installation is required.

## Features

* Stow and unstow packages of dot-files, like GNU Stow does.
* Runs on Windows, Linux and macOS.
* Supports tree folding and unfolding, and `--no-folding` to disable folding.
* Supports `--dotfiles` to stow a `dot-something` entry as `.something`.
* Provides the `dploy clean` command to remove stale symbolic links.
* Stow and unstow operations are atomic and never partially done.
* Fully isolated from any Python installation on the system.

## Usage

```powershell
dploy --version
dploy --help
dploy stow C:\Users\me\dotfiles\bash C:\Users\me
dploy unstow C:\Users\me\dotfiles\bash C:\Users\me
```

## Notes

* This package requires 64-bit Windows.
* An internet connection is required during installation to download the managed Python interpreter and the `dploy` package.
* A uv-managed Python 3.12 interpreter is downloaded during installation.
* The `dploy` command is added to the system `PATH`.
* The `uv` package is installed as a dependency and remains installed after this package is uninstalled.
* Uninstalling the package removes the managed Python interpreter and the virtual environment along with the rest of the package directory.

## License

MIT. See the [project license](https://github.com/arecarn/dploy/blob/master/LICENSE.txt).
