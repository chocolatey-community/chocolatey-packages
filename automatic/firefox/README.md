# <img src="https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/firefox.png" width="48" height="48"/> [Firefox](https://chocolatey.org/packages/Firefox)

Bringing together all kinds of awesomeness to make browsing better for you.

## Features

- A powerful, new engine that’s built for rapidfire performance.
- Better, faster page loading that uses less computer memory.
- Gorgeous design and smart features for intelligent browsing.
- Instantly import your online info and favorites from any other browser.
- The most powerful private browsing mode with added tracking protection.
- Firefox Quantum features: screenshots, pocket, gaming & VR, library.
- Customization Features - addons & extensions, themes, toolbar.
- Synced across devices - passwords, bookmarks, tabs and more.
- Ad tracker blocking.
- Password manager.

## Package Parameters

- `/l:LOCALE` - Install given Firefox locale. See the [official page](https://releases.mozilla.org/pub/firefox/releases/latest/README.txt) for a complete list of available locales.
- `/UseMozillaFallback` Makes a request to mozilla.org and reads the supported Language Culture code from the website.

Command-line options for installer configuration. See the [official page](https://firefox-source-docs.mozilla.org/browser/installer/windows/installer/FullConfig.html) for details and defaults.

- `/InstallDir:PATH`
- `/NoTaskbarShortcut` Do not create Taskbar Shortcut
- `/NoDesktopShortcut` Do not create Desktop Shortcut
- `/NoStartMenuShortcut` Do not create Start Menu Shortcut
- `/NoMaintenanceService` Do not install Maintenance Service
- `/RemoveDistributionDir` Remove Distribution directory on installation/update. (This is the default behavior of the Firefox Installer, but not for this Chocolatey Package)
- `/NoAutoUpdate` Sets a policies.json file to not update Firefox and does not install the Maintenance Service

### Examples

`choco install Firefox --params "/l:en-GB"`
`choco install Firefox --params "/NoTaskbarShortcut /NoDesktopShortcut /NoAutoUpdate"`
`choco install Firefox --params "/l:en-GB /RemoveDistributionDir"`

## Notes

- Looking for Firefox Developer Edition? Install the [firefox-dev](/packages/firefox-dev) package.
- Looking for Firefox Extended Support Release? Install the [FirefoxESR](/packages/FirefoxESR) package.
- If locale package parameter is not present, this package installs Firefox in the first language which matches this list:
  1. If Firefox is already installed it uses the same language as the already installed one.
  1. The Windows system language.
  1. Language Culture code specified on Mozilla website (only when `/UseMozillaFallback` is specified).
  1. If Firefox does not support the system language, it will fall back to `en-US`.
- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**
