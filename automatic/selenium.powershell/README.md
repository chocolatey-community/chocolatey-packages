# Selenium PowerShell Module

The Selenium PowerShell module allows you to automate browser interaction using the [Selenium API](https://selenium.dev/). You can navigate to pages, find elements, click buttons, enter text and even take screenshots.

## Features

- Wraps the C# WebDriver for Selenium
- Easily execute web-based tests
- Works well with Pester

## Package Parameters

The following package parameters can be set:

- `/core` - Installs the module in the AllUsers scope for PowerShell Core
- `/desktop` - Installs the module in the AllUsers scope for Windows PowerShell (ie. Desktop Edition)

To pass parameters, use `--params "''"` (e.g. `choco install selenium.powershell [other options] --params="'/Core'"`).

## Notes

- **If the package is out of date please check [Version History](#versionhistory) for the latest submitted version. If you have a question, please ask it in [Chocolatey Community Package Discussions](https://github.com/chocolatey-community/chocolatey-packages/discussions) or raise an issue on the [Chocolatey Community Packages Repository](https://github.com/chocolatey-community/chocolatey-packages/issues) if you have problems with the package. Disqus comments will generally not be responded to.**
