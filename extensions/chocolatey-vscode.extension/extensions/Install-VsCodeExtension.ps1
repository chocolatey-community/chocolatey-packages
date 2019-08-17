<#
.SYNOPSIS
    Installs an extension into Visual Studio Code.

.DESCRIPTION
    Installs an extension into Visual Studio Code.

    Supports regular and Insider builds of Visual Studio Code.
    Supports also system and user level installations of Visual Studio Code.
    If multiple installations are found the extension is installed in all installations. 

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

    function InstallExtension($installLocation, $executablePath) {
        if (!$installLocation) {
            return
        }

        Write-Verbose "Visual Studio Code installation found at $installLocation"
    
        Write-Host "Installing Visual Studio Code extension $extensionId in $installLocation..."
        Start-ChocolateyProcessAsAdmin -ExeToRun $installLocation -Statements "--install-extension",$extensionId -Elevated:$false
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

    InstallExtension $installLocationSystemLevel $extensionId
    InstallExtension $installLocationUserLevel $extensionId
    InstallExtension $installLocationInsidersSystemLevel $extensionId
    InstallExtension $installLocationInsidersUserLevel $extensionId
}
