# [Selenium Chrome Driver](https://chocolatey.org/packages/selenium-chrome-driver)

WebDriver is an open source tool for automated testing of webapps across many browsers. It provides capabilities for navigating to web pages, user input, JavaScript execution, and more.
ChromeDriver is a standalone server which implements WebDriver's wire protocol (https://github.com/SeleniumHQ/selenium/wiki/JsonWireProtocol) for Chromium.

chromedriver.exe file is located in `«Get-ToolsLocation»/selenium` directory (on default installations this will be `C:\tools\selenium`).

## Package Parameters

The following package parameters can be set:

- `/SkipShim` - informs that the shim file should not be generated

To pass parameters, use `--params "''"` (e.g. `choco install selenium-chrome-driver [other options] --params="'/SkipShim'"`).

## Notes

- Make sure you install the version compatiblity with the Google Chrome Version you are running. Typically the major version of Chrome Drivers are compatible with the equivalent Google Chrome version containing the same major version.
  See their note about compatibility on their download page here: https://sites.google.com/chromium.org/driver/downloads
- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**
