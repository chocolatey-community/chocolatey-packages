# [Selenium Gecko Driver](https://chocolatey.org/packages/selenium-gecko-driver)

Proxy for using W3C WebDriver-compatible clients to interact with Gecko-based browsers.

This program provides the HTTP API described by the WebDriver protocol (http://w3c.github.io/webdriver/webdriver-spec.html#protocol) to communicate with Gecko browsers, such as Firefox.
It translates calls into the Marionette (https://developer.mozilla.org/en-US/docs/Mozilla/QA/Marionette) automation protocol by acting as a proxy between the local- and remote ends.

geckodriver.exe file is located in &lt;Get-ToolsLocation&gt;/selenium directory.

### Package Parameters
The following package parameters can be set:

* `/SkipShim` - informs that the shim file should not be generated

To pass parameters, use `--params "''"` (e.g. `choco install selenium-gecko-driver [other options] --params="'/SkipShim'"`).
