# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@ae1af716af9c16500e7f6f45d650f1dbf3d372fd/icons/vscode-insiders.png" width="48" height="48"/> [vscode-insiders](https://chocolatey.org/packages/vscode-insiders)

Visual Studio Code Insiders is the pre-release build of Visual Studio Code.

Visual Studio Code is a code editor redefined and optimized for building and debugging modern web and cloud applications. It's free, build on open source and available on your favorite platform - Linux, macOS, and Windows.

## Features

- **Meet IntelliSense:** Go beyond syntax highlighting and autocomplete with IntelliSense, which provides smart completions based on variable types, function definitions, and imported modules.
- **Print statement debugging is a thing of the past:** Debug code right from the editor. Launch or attach to your running apps and debug with break points, call stacks, and an interactive console.
- **Git commands built-in:** Working with Git and other SCM providers has never been easier. Review diffs, stage files, and make commits right from the editor. Push and pull from any hosted SCM service.
- **Extensible and customizable:** Want even more features? Install extensions to add new languages, themes, debuggers, and to connect to additional services. Extensions run in separate processes, ensuring they won't slow down your editor. [Learn more about extensions.](https://code.visualstudio.com/docs/editor/extension-gallery)
- **Deploy with confidence and ease:** With [Microsoft Azure](https://azure.microsoft.com/) you can deploy and host your React, Angular, Vue, Node, Python (and more!) sites, store and query relational and document based data, and scale with serverless computing, all with ease, [all from within VS Code](https://code.visualstudio.com/docs/azure/extensions).

## Package parameters

- `/NoDesktopIcon` - Don't add a desktop icon.
- `/NoQuicklaunchIcon` - Don't add an icon to the QuickLaunch area.
- `/NoContextMenuFiles` - Don't add an _Open with Code Insiders_ entry to the context menu for files.
- `/NoContextMenuFolders` - Dont't add an _Open with Code Insiders_ entry to the context menu for folders.
- `/DontAddToPath` - Don't add Visual Studio Code Insiders to the system PATH.

Example: `choco install vscode-insiders --params "/NoDesktopIcon /DontAddToPath"`

## Notes

- The package uses default install options except that it adds context menu entries and Visual Studio Code Insiders isn't started after installation.
- For disabling the auto-update functionality see the [Visual Studio Code Auto Update Deactivation package](https://chocolatey.org/packages/visualstudiocode-disableautoupdate).
- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**

![screenshot](https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@ae1af716af9c16500e7f6f45d650f1dbf3d372fd/automatic/vscode-insiders/screenshot.png)
