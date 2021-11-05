# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-packages@edba4a5849ff756e767cba86641bea97ff5721fe/icons/thunderbird.png" width="48" height="48"/> [thunderbird](https://chocolatey.org/packages/thunderbird)

Thunderbird is a free email application that's easy to set up and customize and it's loaded with great features!

## Package Parameters

- `/l:LOCALE` - Install given Firefox locale. See the [official page](https://releases.mozilla.org/pub/thunderbird/releases/latest/README.txt) for a complete list of available locales.
- /NoRestart - Do not attempt to restart the Thunderbird process
- `/UseMozillaFallback` Makes a request to mozilla.org and reads the supported Language Culture code from the website.

### Examples

`choco install thunderbird --params "/l=en-GB"`  
`choco install thunderbird --params "/NoRestart"`
`choco install thunderbird --params "/UseMozillaFallback"`

## Notes

- If locale package parameter is not present, this package installs Thunderbird in the first language which matches this list:
  1. If Thunderbird is already installed: the same language as the already installed Thunderbird.
  1. The Windows system language where the Thunderbird package gets installed.
  1. Language Culture code specified on Mozilla website (only when `/UseMozillaFallback` is specified).
  1. If Thunderbird does not support the system language, it will fallback to `en-US`.
