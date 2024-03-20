# [<img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@5633c4413a8b71f75f379190546a0047c0e0b12b/icons/cmake.png" height="48" width="48" /> CMake (Install)](https://chocolatey.org/packages/cmake.install)

CMake is an open-source, cross-platform family of tools designed to build, test and package software. CMake is used to control the software compilation process using simple platform and compiler independent configuration files, and generate native makefiles and workspaces that can be used in the compiler environment of your choice. The suite of CMake tools were created by Kitware in response to the need for a powerful, cross-platform build environment for open-source projects such as ITK and VTK.

[Development](https://www.cmake.org/developer-resources/)

#### MSI Properties

`ADD_CMAKE_TO_PATH`
- `None` - Do not add CMake to PATH (default)
- `System` - Add CMake to system PATH for __all users__
- `User` - Add CMake to PATH for __the current user__

`DESKTOP_SHORTCUT_REQUESTED`
- `0` = Do not create desktop icon (default)
- `1` = Create CMake desktop icon

`ALLUSERS`
- `0` = Install for the current user only
- `1` = Install for all users (default)

For example: `choco install cmake --installargs 'ADD_CMAKE_TO_PATH=System'`

## Notes

- This package [follows the installer default behavior](https://gitlab.kitware.com/cmake/cmake/-/issues/21465) of not adding the `cmake.exe` to the PATH. If you need `cmake.exe` on the path, please see the **MSI Properties** example, above, or install the [`cmake.portable` package](https://community.chocolatey.org/packages/cmake.portable).
- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**