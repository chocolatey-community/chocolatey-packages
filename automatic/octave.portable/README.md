# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@aa4dfe9a33e28ea4a94616e84b3648527d4fa87f/icons/octave.png" width="48" height="48"/> [octave.portable](https://chocolatey.org/packages/octave.portable)

## GNU Octave - Scientific Programming Language

GNU Octave is a high-level language, primarily intended for numerical computations. It provides a convenient command line interface for solving linear and nonlinear problems numerically, and for performing other numerical experiments using a language that is mostly compatible with Matlab. It may also be used as a batch-oriented language.

Octave has extensive tools for solving common numerical linear algebra problems, finding the roots of nonlinear equations, integrating ordinary functions, manipulating polynomials, and integrating ordinary differential and differential-algebraic equations. It is easily extensible and customizable via user-defined functions written in Octave’s own language, or using dynamically loaded modules written in C++, C, Fortran, or other languages.

## Features

* Powerful mathematics-oriented syntax with built-in plotting and visualization tools
* Drop-in compatible with many Matlab scripts
* Octave Forge, a central location for development of packages for GNU Octave, similar to Matlab's toolboxes.
* Free software, runs on GNU/Linux, macOS, BSD, and Windows

## Package parameters

The following package parameters can be set:

* `/DesktopIcon` - Add icons for Octave to the Desktop. By default no icons are added.
* `/StartMenu`   - Add icons for Octave to the Start Menu. By default no icons are added.
* `/LocalUser`   - Install only for local user. By default any Octave shortcuts will be installed for all users.

Example: `choco install octave.install --params "/DesktopIcon /StartMenu /LocalUser"`

## Notes

* The package makes Octave available through the `octave` (GUI) and  `octave-cli` (CLI) shims following installation
