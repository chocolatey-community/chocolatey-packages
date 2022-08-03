# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@a37f40763d259eab20d0462b72cba86a108441d9/icons/totalcommander.png" width="48" height="48"/> [totalcommander](https://chocolatey.org/packages/totalcommander)


Total Commander is a file manager for Windows, a tool like the Explorer or file manager, which comes with windows.
But Total Commander uses a different approach: it has two fixed windows, which makes copying files much easier.

## Features

* Two file windows side by side
* Multiple language and Unicode support
* Enhanced search function
* Compare files (now with editor) / synchronize directories
* Quick View panel with bitmap display
* ZIP, 7ZIP, ARJ, LZH, RAR, UC2, TAR, GZ, CAB, ACE archive handling + plugins
* Built-in FTP client with FXP (server to server) and HTTP proxy support
* Parallel port link, multi-rename tool
* Tabbed interface, regular expressions, history+favorites buttons
* Thumbnails view, custom columns, enhanced search
* Compare editor, cursor in lister, separate trees, logging, enhanced overwrite dialog etc.
* Unicode names almost everywhere, long names (>259 characters), password manager for ftp and plugins, synchronize empty dirs, 64 bit context menu, quick file filter (Ctrl+S)
* USB port connection via special [direct transfer cable](http://ghisler.com/cables/index.htm), partial branch view (Ctrl+Shift+B), and many improvements to ftp, synchronizing and other functions
* [And many more!](http://ghisler.com/featurel.htm)

[FAQ](http://www.ghisler.com/faq.htm)
[Plugins](http://www.ghisler.ch/wiki/index.php/Developer%27s_corner)
[Plugin downloads](http://totalcmd.net/)
[Plugin development](http://totalcmd.net/directory/developer.html)

## Package parameters

The following package parameters can be set:

* `/DesktopIcon` - Add an icon for Total Commander to the Desktop. By default no icon is added.
* `/InstallPath` - Use custom install path. By default Total Commander is installed to the `%ProgramFiles%\totalcmd` directory.
* `/DefaultFM`   - Use TC as default file manager instead of Explorer. Use `/DefaultFM:explorer` to return to Explorer.
* `/ShellExtension` - Add Total Commander in shell context menu for directories.

These parameters can be passed to the installer with the use of `--params`. For example: `--params '/DesktopIcon'`.

## Notes

- For list of Total Commander plugin packages, see [tcps](https://community.chocolatey.org/packages/tcps) package.
- This package sets system environment variable `COMMANDER_PATH` which points to the Total Commander install directory.
- This package contains the combined Total Commander installer which contains both x32 and x64 bit versions.
- Total Commander is a Shareware program. This means that you can test it for a period of 30 days. After testing the program, you must either [order the full version](http://www.ghisler.com/order.htm), or delete the program from your harddisk.
- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**
