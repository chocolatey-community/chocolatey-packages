# CHANGELOG

## 1.3.3

- Bugfix `Get-AppInstallLocation`: fix path is directory

## 1.3.2

- Bugfix `Get-AppInstallLocation`: now checks if path is directory

## 1.3.1
- Bugfix in `Get-AppInstallLocation`: Removed extra `$location` parameter from Split-Path when parsing the registry UninstallString.

## 1.3.0

- `Get-EffectiveProxy`: Get the current proxy using several methods

## 1.2.0

- Use `$IgnoredArguments` in all functions to allow for future expansion and splatting ([#621](https://github.com/chocolatey/chocolatey-coreteampackages/issues/621))
- Bugfix in `Get-PackageParameters` parsing of paths containing symbol chars.

## 1.1.0
- `Get-AvailableDriveLetter`: Get the next unused drive letter

## 1.0.7
- Bugfix in `Get-PackageParameters`: flags can now have numbers in their names, whereas before, everything past the number would be truncated and the flag would turn into a boolean.

## 1.0.6
- Bugfix in `Get-AppInstallLocation`: Powershell 2 can not replace on null value.

## 1.0.5

- Bugfix in `Get-UninstallRegistryKey`: Powershell 2 compatibility.
- Slightly improved documentation of `Get-UninstallRegistryKey`.

## 1.0.4

- Bugfix in `Get-PackageParameters`: Powershell 2 bug workaround ([#465](https://github.com/chocolatey/chocolatey-coreteampackages/issues/465)).

## 1.0.3

- Bugfix in `Get-PackageParameters`: error when parsing of path.

## 1.0.2

- Bugfix in `Get-PackageParameters`: PowerShell 2 compatibility.

## 1.0.1

- Bugfix in `Get-PackageParameters`: unaliased `sls` to work on PowerShell 2.

## 1.0

- Merged `mm-choco.extension`.
- Merged `chocolatey-uninstall.extension`.
- Added `Get-PackageCacheLocation`
- Added `CHANGELOG.md` and `README.md`.
- Refactoring and more documentation.

## 0.1.3

- `Get-WebContent`:  Download file with choco internals.
