# [<img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/5633c4413a8b71f75f379190546a0047c0e0b12b/icons/cmake.png" height="48" width="48" /> CMake (Install)](https://chocolatey.org/packages/cmake.install)

CMake is an open-source, cross-platform family of tools designed to build, test and package software. CMake is used to control the software compilation process using simple platform and compiler independent configuration files, and generate native makefiles and workspaces that can be used in the compiler environment of your choice. The suite of CMake tools were created by Kitware in response to the need for a powerful, cross-platform build environment for open-source projects such as ITK and VTK.

[Development](https://www.cmake.org/developer-resources/)

#### MSI Properties
`ADD_CMAKE_TO_PATH`
* `None` - Do not add CMake to path (default)
* `System` - Add CMake to system PATH for __all users__
* `User` - Add CMake to system PATH for __current user__

`DESKTOP_SHORTCUT_REQUESTED`
* `0` = Do not create desktop icon (default)
* `1` = Create CMake desktop icon

`ALLUSERS`
* `0` = Install for the current user only
* `1` = Install for all users (default)

For example: `choco install cmake --installargs 'ADD_CMAKE_TO_PATH=""User""'`
