# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/thunderbird.png" width="48" height="48"/> [thunderbird](https://chocolatey.org/packages/thunderbird)

Thunderbird is a free email application that's easy to set up and customize and it's loaded with great features!

## Package Parameters

- `/l:LOCALE` - Install given Firefox locale. See the [official page](https://releases.mozilla.org/pub/thunderbird/releases/latest/README.txt) for a complete list of available locales.
- `/UseMozillaFallback` Makes a request to mozilla.org and reads the supported Language Culture code from the website.
- `/NoStop` - Do not stop Thunderbird before running the install if it is running or attempt to restart it after install.

Command-line options for installer configuration. See the [official page](https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html) for details and defaults.

- `/InstallDir:PATH`
- `/NoTaskbarShortcut` Do not create Taskbar Shortcut
- `/NoDesktopShortcut` Do not create Desktop Shortcut
- `/NoStartMenuShortcut` Do not create Start Menu Shortcut
- `/NoMaintenanceService` Do not install Maintenance Service
- `/RemoveDistributionDir` Remove Distribution directory on installation/update. (This is the default behavior of the Thunderbird Installer, but not for this Chocolatey Package)
- `/NoAutoUpdate` Sets a policies.json file to not update Thunderbird and does not install the Maintenance Service

### Examples

`choco install thunderbirdesr --params "/l=en-GB"`
`choco install thunderbirdesr --params "/NoTaskbarShortcut /NoDesktopShortcut /NoAutoUpdate"`    
`choco install thunderbirdesr --params "/UseMozillaFallback"`
`choco install thunderbirdesr --params "/NoStop"`

## Notes
- Looking for Thunderbird monthly release? Install the [thunderbird](/packages/thunderbird) package.
- If locale package parameter is not present, this package installs Thunderbird in the first language which matches this list:
  1. If Thunderbird is already installed: the same language as the already installed Thunderbird.
  1. The Windows system language where the Thunderbird package gets installed.
  1. Language Culture code specified on Mozilla website (only when `/UseMozillaFallback` is specified).
  1. If Thunderbird does not support the system language, it will fallback to `en-US`.
- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**
