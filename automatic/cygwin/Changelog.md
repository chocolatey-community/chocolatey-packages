# Package changelog for [cygwin](https://chocolatey.org/packages/cygwin)

## Version: 3.0.7.20191022

- **BUGS:** Fixed permission bug when package was installed when `$Env:ChocolateyToolsLocation` wasn't created yet [#1291](https://github.com/chocolatey-community/chocolatey-coreteampackages/issues/1291)

## Version: 2.11.2.20181212 (2018-12-12)

- **BUGS:** Using cygwin x86 as the source tries to install x64 version of cygwin (thanks to [@OXINARF](https://github.com/OXINARF) for providing the fix in PR [#1165](https://github.com/chocolatey/chocolatey-coreteampackages/pull/1165))

## Version: 2.8.1 (2017-07-03)

- **BUGS:** Removed admin tag

## Version: 2.8.0.20170607 (2017-06-07)

- **BUGS:** Changed docs url to https equivalent
- **ENHANCEMENT:** Added changelog for package
- **ENHANCEMENT:** Embedded cygwin package
- **ENHANCEMENT:** Extracted Description to its own file
