# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/aad7c15bfbec43c3716f8a82bc3af22e1a55579d/icons/ruby.svg" width="48" height="48"/> [ruby](https://chocolatey.org/packages/ruby)

Ruby is a dynamic, open source programming language with a focus on simplicity and productivity. It has an elegant syntax that is natural to read and easy to write.

This package provides a self-contained [Windows-based installer](https://rubyinstaller.org) that includes the Ruby language, an execution environment, important documentation, and more.

## Package Parameters

- `/InstallDir` - Ruby installation directory, by default `c:\tools\RubyXY` where XY are major and minor version parts.
- `/NoPath`     - Do not add ruby bin folder to machine PATH.

## Notes

- To install ruby development kit ruby installer provides `ridk` command. It provides easy way to install msys2 via `ridk install 1`, however, the installation is interactive. To accomplish unattended install, use [msys2](https://chocolatey.org/packages/msys2) package.

