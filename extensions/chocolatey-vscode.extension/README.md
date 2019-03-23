# chocolatey-vscode.extension

This is a Chocolatey extension that simplifies building Chocolatey packages which install Visual Studio Code extensions.

## Installation

Install via chocolatey: `choco install chocolatey-vscode.extension`.

The module is usually automatically installed as a dependency.

## Usage

To create a package that uses a function from this extension add the following to the `nuspec` specification:

```xml
<dependencies>
    <dependency id="chocolatey-vscode.extension" version="SPECIFY_LATEST_VERSION" />
</dependencies>
```

**NOTE**: Make sure you use adequate _minimum_ version.

To test the functions you can import the module directly or via the `chocolateyInstaller.psm1` module:

```powershell
PS> import-module $Env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
PS> import-module $Env:ChocolateyInstall\extensions\chocolatey-vscode\*.psm1
```

You can now test any of the functions:

```powershell
PS>  Install-VsCodeExtension gep13.chocolatey-vscode -Verbose

VERBOSE: Trying to locate Visual Studio Code executable...
VERBOSE: Visual Studio Code install directory found at C:\Program Files\Microsoft VS Code\bin\code.cmd
Installing Visual Studio Code extension gep13.chocolatey-vscode...
```

Keep in mind that function may work only in the context of the `chocolateyInstaller.ps1`.

To get the list of functions, load the module directly and invoke the following command:

```powershell
Get-Command -Module chocolatey-vscode
```

To get the help for the specific function use `man`:

```powershell
man Install-VsCodeExtension
```
