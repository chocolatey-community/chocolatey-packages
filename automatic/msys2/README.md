# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/b7fd5a569573c45748462808cd80dc4b456f79c1/icons/msys2.png" width="48" height="48"/> [msys2](https://chocolatey.org/packages/msys2)

MSYS2 is a software distro and building platform for Windows.

At its core is an independent rewrite of MSYS, based on modern Cygwin (POSIX compatibility layer) and MinGW-w64 with the aim of better interoperability with native Windows software. It provides a bash shell, Autotools, revision control systems and the like for building native Windows applications using MinGW-w64 toolchains.

It features a package management system to provide easy installation of packages, Pacman. It brings many powerful features such as dependency resolution and simple complete system upgrades, as well as straight-forward package building.

## Package parameters

- `/InstallDir` - Path to installation directory, by default msys will be installed in `Get-ToolsLocation`.
- `/NoPath`     - Do not add msys installation directory to system PATH.
- `/NoUpdate`   - Do not automatically update with Pacman according to the [official instructions](https://msys2.github.io).

## Notes

- MSYS2 itself will not be installed again on updating or reinstalling the Chocolatey package. Instead, the existing MSYS2 will be updated with Pacman. Manually delete the installation folder to force complete reinstallation.

### Ruby integration

This package can be used with [ruby](https://chocolatey.org/packages/ruby) package to provide native building environment for gems. 

- The ruby installer comes with `ridk` function which offers interactive GUI installation wizard of msys2 and hence [can't be used unattended](https://github.com/oneclick/rubyinstaller2/issues/79) (`ridk install 1`). 
- Its system update is the same as initialization done with this package (`ridk install 2`). 
- Ruby installer offers unattended setup of MSYS2 and MINGW development toolchain (`ridk install 3`). 

You can also just install the msys2 package without system update and use `ridk` afterwards:

```powershell
cinst ruby                        # install ruby
cinst msys2 --params "/NoUpdate"  # install msys2 without system update
Update-SessionEnvironment         # refresh environment vars
ridk install 2 3                  # use ruby's ridk to update the system and install development toolchain
```
