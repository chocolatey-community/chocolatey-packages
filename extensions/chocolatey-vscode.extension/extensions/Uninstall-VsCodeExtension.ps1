<#
.SYNOPSIS
    Uninstalls an extension from Visual Studio Code.

.DESCRIPTION
    Uninstalls an extension from Visual Studio Code.

    Use -Verbose parameter to see which location of Visual Studio Code is used.

.EXAMPLE
    PS> Uninstall-VsCodeExtension gep13.chocolatey-vscode

    Uninstalls the 'gep13.chocolatey-vscode' extension from Visual Studio Code.
#>
function Uninstall-VsCodeExtension {
    [CmdletBinding()]
    param(
        # Identifier of the Visual Studio Code extension
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

    Write-Host "Uninstalling Visual Studio Code extension $extensionId..."
    Start-ChocolateyProcessAsAdmin -ExeToRun $codePath -Statements "--uninstall-extension",$extensionId
}
