# chocolatey-azuredatastudio.extension

This is a Chocolatey extension that simplifies building Chocolatey packages which install Azure Data Studio extensions.

## Installation

Install via chocolatey: `choco install chocolatey-azuredatastudio.extension`.

The module is usually automatically installed as a dependency.

## Usage

To create a package that uses a function from this extension add the following to the `nuspec` specification:

```xml
<dependencies>
    <dependency id="chocolatey-azuredatastudio.extension" version="SPECIFY_LATEST_VERSION" />
</dependencies>
```

**NOTE**: Make sure you use adequate _minimum_ version.

To test the functions you can import the module directly or via the `chocolateyInstaller.psm1` module:

```powershell
PS> import-module $Env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
PS> import-module $Env:ChocolateyInstall\extensions\chocolatey-azuredatastudio\*.psm1
```

You can now test any of the functions:

```powershell
PS>  Install-AzureDataStudioExtension "PowerShell-2019.5.0.vsix" -Verbose

VERBOSE: Trying to locate Azure Data Studio executable...
VERBOSE: Azure Data Studio install directory found at C:\Program Files\Azure Data Studio\bin\azuredatastudio.cmd
Installing Azure Data Studio extension ms-vscode.PowerShell...
```

Keep in mind that function may work only in the context of the `chocolateyInstaller.ps1`.

To get the list of functions, load the module directly and invoke the following command:

```powershell
Get-Command -Module chocolatey-azuredatastudio
```

To get the help for the specific function use `man`:

```powershell
man Install-AzureDataStudioExtension
```
