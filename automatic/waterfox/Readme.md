# <img src="https://cdn.jsdelivr.net/gh/chocolatey-community/chocolatey-coreteampackages@2171e76d9468526e4e792d20ac6b68e1a8fdc93a/icons/waterfox.png" width="48" height="48"/> [waterfox](https://chocolatey.org/packages/waterfox)

Waterfox is a specialized modification of the Mozilla platform, designed for privacy and user choice in mind. Other modifications and patches that are more upstream have been implemented as well to fix any compatibility/security issues that Mozilla may lag behind in implementing (usually due to not being high priority). High request features removed by Mozilla but wanted by users are retained (if they aren't removed due to security).


## Features

* Disabled Encrypted Media Extensions (EME)
* Disabled Web Runtime (deprecated as of 2015)
* Removed Pocket
* Removed Telemetry
* Removed data collection
* Removed startup profiling
* Allow running of all 64-Bit NPAPI plugins
* Allow running of unsigned extensions
* Removal of Sponsored Tiles on New Tab Page
* Addition of Duplicate Tab option
* Locale selector in about:preferences > General (further improved by PandaCodex)

## Notes

- Due to the change of the version scheme which would made newer versions be considered outdated on Chocolatey Gallery, the year and date prefix are added to the version in the format `yyMM`.
