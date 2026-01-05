# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@aad7c15bfbec43c3716f8a82bc3af22e1a55579d/icons/ruby.svg" alt="red beryl icon" width="48" height="48" /> [ruby.install](https://chocolatey.org/packages/ruby.install)

Ruby is a dynamic, open source programming language focused on simplicity and
productivity. It has an elegant syntax that is natural to read and easy to
write.

This package provides a self-contained
[Windows-based installer](https://rubyinstaller.org/) that includes the Ruby
language, an execution environment, important documentation and more.

## Package Parameters

- `/InstallDir:<customPath>`: The top-level installation directory,
  `"${Env:ChocolateyToolsLocation}\rubyXY"` by default (where `X` and `Y` are
  the major and minor semantic version integer components)
- `/NoPath`: Do not add the folder containing the Ruby interpreter binary to the
  System PATH environment variable
- `/NoFileAssoc`: Do not associate the  `*.rb`/`*.rbw` file extensions with the
  newly-installed Ruby interpreter
- `/DefaultUTF8`: Set the interpreter to parse all input as UTF-8 by setting the
  System RUBYOPT environment variable to the value `-Eutf-8`

### Example

```pwsh
choco install ruby.install --package-parameters="'/NoPath /InstallDir:C:\your\install\path'"
```

## Notes

To install the Ruby Development Kit, the installer provides the `ridk` command.
It provides an easy way to install MSYS2 by invoking `ridk install 1`, however,
the installation is interactive. For an unattended MSYS2 installation, use the
[msys2](https://chocolatey.org/packages/msys2) Chocolatey package.
