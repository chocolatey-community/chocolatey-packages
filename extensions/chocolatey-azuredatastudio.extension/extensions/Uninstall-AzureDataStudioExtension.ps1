<#
.SYNOPSIS
    Uninstalls an extension from Azure Data Studio.

.DESCRIPTION
    Uninstalls an extension from Azure Data Studio.

    Supports regular and Insider builds of Azure Data Studio.
    Supports also system and user level installations of Azure Data Studio.
    If multiple installations are found the extension is uninstalled from all installations. 

    Use -Verbose parameter to see which location of Azure Data Studio is used.

.EXAMPLE
    PS> Uninstall-AzureDataStudioExtension ms-vscode.PowerShell

    Uninstalls the 'ms-vscode.PowerShell' extension from Azure Data Studio.
#>
function Uninstall-AzureDataStudioExtension {
    [CmdletBinding()]
    param(
        # Identifier of the Azure Data Studio extension
        [Parameter(Mandatory = $true)]
        [string]$extensionId
    )

    function UninstallExtension($installLocation, $executablePath) {
        if (!$installLocation) {
            return
        }

        Write-Verbose "Azure Data Studio installation found at $installLocation"
    
        Write-Host "Uninstalling Azure Data Studio extension $extensionId from $installLocation..."
        Start-ChocolateyProcessAsAdmin -ExeToRun $installLocation -Statements "--uninstall-extension",$extensionId -Elevated:$false
    }

    Write-Verbose "Locating Azure Data Studio system level installation directory..."
    $installLocationSystemLevel = Get-AppInstallLocation "Azure Data Studio" | Where-Object { Test-Path "$_\bin\azuredatastudio.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\azuredatastudio.cmd" }

    Write-Verbose "Locating Azure Data Studio user level installation directory..."
    $installLocationUserLevel = Get-AppInstallLocation "Azure Data Studio (User)" | Where-Object { Test-Path "$_\bin\azuredatastudio.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\azuredatastudio.cmd" }

    Write-Verbose "Locating Azure Data Studio Insiders build system level installation directory..."
    $installLocationInsidersSystemLevel = Get-AppInstallLocation "Azure Data Studio - Insiders" | Where-Object { Test-Path "$_\bin\azuredatastudio-insiders.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\azuredatastudio-insiders.cmd" }

    Write-Verbose "Locating Azure Data Studio Insiders build user level installation directory..."
    $installLocationInsidersUserLevel = Get-AppInstallLocation "Azure Data Studio - Insiders (User)" | Where-Object { Test-Path "$_\bin\azuredatastudio-insiders.cmd" } | Select-Object -first 1 | ForEach-Object { "$_\bin\azuredatastudio-insiders.cmd" }

    if (!$installLocationSystemLevel -and !$installLocationUserLevel -and !$installLocationInsidersSystemLevel -and !$installLocationInsidersUserLevel) {
        Write-Error "Azure Data Studio installation directory was not found."
        throw "Azure Data Studio installation directory was not found."
    }

    UninstallExtension $installLocationSystemLevel $extensionId
    UninstallExtension $installLocationUserLevel $extensionId
    UninstallExtension $installLocationInsidersSystemLevel $extensionId
    UninstallExtension $installLocationInsidersUserLevel $extensionId
}
