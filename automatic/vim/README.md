# <img src="https://raw.githubusercontent.com/chocolatey-community/chocolatey-coreteampackages/master/icons/vim.svg" width="48" height="48"/> [vim](https://chocolatey.org/packages/vim)

Vim is a highly configurable text editor built to enable efficient text editing. It is an improved version of the vi editor distributed with most UNIX systems.

Vim is often called a programmer's editor, and so useful for programming that many consider it an entire IDE. It's not just for programmers, though. Vim is perfect for all kinds of text editing, from composing email to editing configuration files.

## Features

* **Vim**: Vim terminal(CLI) application can be used from Powershell and Command Prompt.

* **GVim**: The GUI version of Vim provides full featured Windows GUI application experience.

* **Terminal Integration**: Batch files are created to provide `vim`, `gvim`, `evim`, `view`, `gview`, `vimdiff`, `gvimdiff` and `vimtutor` command on terminal use.

* **Shell Integration**: Vim is added in `Open with ...` context menu. And by default `Edit with Vim` context menu is created to open files whose extensions are associated with other applications.

## Package parameters

- `/InstallDir` - Override the installation directory. By default, the software is installed in `$ChocolateyToolsLocation`, it's default value is `C:\tools`. You can include spaces. See the example below.
- `/RestartExplorer` - Restart Explorer to unlock `GVimExt.dll` used for `Edit with Vim` context menu feature.
- `/NoDefaultVimrc` - Don't create default `_vimrc` file.
- `/NoContextmenu` - Don't create `Edit with Vim` context menu.
- `/NoDesktopShortcuts` - Don't create shortcuts on the desktop.

Example: `choco install vim --params "'/NoDesktopShortcuts /InstallDir:C:\path\to\your dir'"`

## Notes

- This package uses the ZIP build to install to provide installation parameters.
- All compilation of the software is automated and performed on Appveyor. The building status is open.
- This package provides an official build. Similar package `vim-tux` is from a well-known unofficial vim building project. Unlike `vim-tux`, this package can take some installation parameters.
- See https://github.com/vim/vim-win32-installer for more information.

