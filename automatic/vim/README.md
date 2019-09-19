# <img src="https://raw.githubusercontent.com/chocolatey-community/chocolatey-coreteampackages/master/icons/vim.svg" width="48" height="48"/> [vim](https://chocolatey.org/packages/vim)

Vim is a highly configurable text editor built to enable efficient text editing. It is an improved version of the vi editor distributed with most UNIX systems.

Vim is often called a programmer’s editor, and so useful for programming that many consider it an entire IDE. It’s not just for programmers, though. Vim is perfect for all kinds of text editing, from composing email to editing configuration files.

This package provides official nightly build.

The software is installed to chocolatey tools directory.

#### Parameters
Some parameters can be set.

 * `/RestartExplorer` - Restart explorer to unlock `GVimExt.dll` used for context menu popup feature.
 * `/NoDefaultVimrc` - Don't create default `_vimrc` file.
 * `/NoContextmenu` - Don't create `Edit with Vim` in context menu.
 * `/NoDesktopShortcuts` - Don't create shortcuts on the desktop.

See https://github.com/vim/vim-win32-installer for more information.
