# chocolatey-core.extension

This is the Powershell module that extends Chocolatey with new functions.

## Installation

Install via chocolatey: `choco install chocolatey-core.extension`.

The module is usually automatically installed as a dependency.

## Usage

To create a package that uses an extension function add the following to the `nuspec` specification:

    <dependencies>
        <dependency id="chocolatey-core.extension" version="SPECIFY_LATEST_VERSION" />
    </dependencies>

**NOTE**: Make sure you use adequate _minimum_ version.

To test the functions you can import the module directly or via the `chocolateyInstaller.psm1` module:

    PS> import-module $Env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
    PS> import-module $Env:ChocolateyInstall\extensions\chocolatey-core\*.psm1

You can now test any of the functions:

    PS>  Get-AppInstallLocation choco -Verbose

    VERBOSE: Trying local and machine (x32 & x64) Uninstall keys
    VERBOSE: Trying Program Files with 2 levels depth
    VERBOSE: Trying PATH
    C:\ProgramData\chocolatey\bin

Keep in mind that function may work only in the context of the `chocolateyInstaller.ps1`.

To get the list of functions, load the module directly and invoke the following command:

    Get-Command -Module chocolatey-core

To get the help for the specific function use `man`:

    man Get-UninstallRegistryKey



