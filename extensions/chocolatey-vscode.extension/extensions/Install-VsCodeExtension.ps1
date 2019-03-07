<#
.SYNOPSIS
    Installs an extension into Visual Studio Code.

.DESCRIPTION
    Installs an extension into Visual Studio Code.

    Use -Verbose parameter to see which location of Visual Studio Code is used.

.EXAMPLE
    PS> Install-VsCodeExtension gep13.chocolatey-vscode

    Installs the latest version of the 'gep13.chocolatey-vscode' extension in Visual Studio Code.
    Visual Studio Code will auto-update the extension whenever a new version of the extension is released.

.EXAMPLE
    PS> Install-VsCodeExtension gep13.chocolatey-vscode@0.5.0

    Installs version 0.5.0 of the 'gep13.chocolatey-vscode' extension in Visual Studio Code.

    Requires Visual Studio Code 1.30.0 or newer.

    Note that the extension currently will be updated to the latest version on next startup.
    See https://github.com/Microsoft/vscode/issues/63903

.EXAMPLE
    PS> Install-VsCodeExtension "chocolatey-vscode.vsix"

    Installs the extension provided by the VSIX file.

    Note that the extension will be updated to the latest version on next startup.
#>
function Install-VsCodeExtension {
    [CmdletBinding()]
    param(
        # Identifier and optional version or full path to the VSIX of the Visual Studio Code extension.
        [Parameter(Mandatory = $true)]
        [string]$extensionId
    )

    Write-Verbose "Locating Visual Studio Code installation directory..."
    $codePath = Get-AppInstallLocation "Microsoft Visual Studio Code" | Where-Object { Test-Path "$_\bin\code.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\code.cmd" }
   
    if (!$codePath) {
      Write-Error "Visual Studio Code installation directory was not found."
      throw "Visual Studio Code installation directory was not found."
    }

    Write-Verbose "Visual Studio Code installation found at $codePath"

    Write-Host "Installing Visual Studio Code extension $extensionId..."
    Start-ChocolateyProcessAsAdmin -ExeToRun $codePath -Statements "--install-extension",$extensionId
}
