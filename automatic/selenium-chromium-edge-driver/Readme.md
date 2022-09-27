# <img src="" width="48" height="48"/> [Selenium Chromium Edge Driver](https://chocolatey.org/packages/selenium-chromium-edge-driver)

WebDriver is an open source tool for automated testing of webapps across many browsers. It provides capabilities for navigating to web pages, user input, JavaScript execution, and more. MSEdgeDriver is a standalone server which implements WebDriver's wire protocol (https://github.com/SeleniumHQ/selenium/wiki/JsonWireProtocol) for Chromium.

msedgedriver.exe file is located in `«Get-ToolsLocation»/selenium` directory.

## Package Parameters

The following package parameters can be set:

* `/SkipShim` - informs that the shim file should not be generated

To pass parameters, use `--params "''"` (e.g. `choco install selenium-chromium-edge-driver [other options] --params="'/SkipShim'"`).
