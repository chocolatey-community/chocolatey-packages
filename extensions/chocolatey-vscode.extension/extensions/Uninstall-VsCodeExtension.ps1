<#
.SYNOPSIS
    Uninstalls an extension from Visual Studio Code.

.DESCRIPTION
    Uninstalls an extension from Visual Studio Code.

    Supports regular and Insider builds of Visual Studio Code.
    Supports also system and user level installations of Visual Studio Code.
    If multiple installations are found the extension is uninstalled from all installations. 

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

    function UninstallExtension($installLocation, $executablePath) {
        if (!$installLocation) {
            return
        }

        Write-Verbose "Visual Studio Code installation found at $installLocation"
    
        Write-Host "Uninstalling Visual Studio Code extension $extensionId from $installLocation..."
        Start-ChocolateyProcessAsAdmin -ExeToRun $installLocation -Statements "--uninstall-extension",$extensionId -Elevated:$false
    }

    Write-Verbose "Locating Visual Studio Code system level installation directory..."
    $installLocationSystemLevel = Get-AppInstallLocation "Microsoft Visual Studio Code" | Where-Object { Test-Path "$_\bin\code.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\code.cmd" }

    Write-Verbose "Locating Visual Studio Code user level installation directory..."
    $installLocationUserLevel = Get-AppInstallLocation "Microsoft Visual Studio Code (User)" | Where-Object { Test-Path "$_\bin\code.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\code.cmd" }

    Write-Verbose "Locating Visual Studio Code Insiders build system level installation directory..."
    $installLocationInsidersSystemLevel = Get-AppInstallLocation "Microsoft Visual Studio Code Insiders" | Where-Object { Test-Path "$_\bin\code-insiders.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\code-insiders.cmd" }

    Write-Verbose "Locating Visual Studio Code Insiders build user level installation directory..."
    $installLocationInsidersUserLevel = Get-AppInstallLocation "Microsoft Visual Studio Code Insiders (User)" | Where-Object { Test-Path "$_\bin\code-insiders.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\code-insiders.cmd" }

    if (!$installLocationSystemLevel -and !$installLocationUserLevel -and !$installLocationInsidersSystemLevel -and !$installLocationInsidersUserLevel) {
        Write-Error "Visual Studio Code installation directory was not found."
        throw "Visual Studio Code installation directory was not found."
    }

    UninstallExtension $installLocationSystemLevel $extensionId
    UninstallExtension $installLocationUserLevel $extensionId
    UninstallExtension $installLocationInsidersSystemLevel $extensionId
    UninstallExtension $installLocationInsidersUserLevel $extensionId
}
