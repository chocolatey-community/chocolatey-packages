# [<img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/c38961f6c3e526524e3648e6710e2cfbb2e82c05/icons/cmake.png" height="48" width="48" /> cmake](https://chocolatey.org/packages/cmake.install)

CMake is a family of tools designed to build, test and package software. CMake is used to control the software compilation process using simple platform and compiler independent configuration files. CMake generates native makefiles and workspaces that can be used in the compiler environment of your choice.

[Development](https://www.cmake.org/developer-resources/)

#### MSI Properties
`ADD_CMAKE_TO_PATH`
* `None` - Do not add CMake to path (default)
* `System` - Add CMake to system PATH for __all users__
* `User` - Add CMake to system PATH for __current user__

`DESKTOP_SHORTCUT_REQUESTED`
* `0` = Do not create desktop icon (default)
* `1` = Create CMake desktop icon

For example: `choco install cmake --installargs 'ADD_CMAKE_TO_PATH=""User""'`
