# CHANGELOG

## 1.0.6
- Bufix in `Get-AppInstallLocation`: Powershell 2 can not replace on null value.

## 1.0.5

- Bugfix in `Get-UninstallRegistryKey`: Powershell 2 compatibility.
- Slightly improved documentation of `Get-UninstallRegistryKey`.

## Version 1.0.4

- Bugfix in `Get-PackageParameters`: Powershell 2 bug workaround ([#465](https://github.com/chocolatey/chocolatey-coreteampackages/issues/465)).

## Version 1.0.3

- Bugfix in `Get-PackageParameters`: error when parsing of path.

## Version 1.0.2

- Bugfix in `Get-PackageParameters`: PowerShell 2 compatibility.

## Version 1.0.1

- Bugfix in `Get-PackageParameters`: unaliased `sls` to work on PowerShell 2.

## Version 1.0

- Merged `mm-choco.extension`.
- Merged `chocolatey-uninstall.extension`.
- Added `Get-PackageCacheLocation`
- Added `CHANGELOG.md` and `README.md`.
- Refactoring and more documentation.

## Version 0.1.3

- `Get-WebContent` -  Download file with choco internals.
