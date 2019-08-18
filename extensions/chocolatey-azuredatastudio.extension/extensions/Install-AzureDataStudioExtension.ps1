<#
.SYNOPSIS
    Installs an extension into Azure Data Studio.

.DESCRIPTION
    Installs an extension into Azure Data Studio.

    Supports regular and Insider builds of Azure Data Studio.
    Supports also system and user level installations of Azure Data Studio.
    If multiple installations are found the extension is installed in all installations. 

    Use -Verbose parameter to see which location of Azure Data Studio is used.

.EXAMPLE
    PS> Install-AzureDataStudioExtension microsoft.admin-pack

    Installs the latest version of the 'microsoft.admin-pack' extension in Azure Data Studio.
    Azure Data Studio will auto-update the extension whenever a new version of the extension is released.

.EXAMPLE
    PS> Install-AzureDataStudioExtension "PowerShell-2019.5.0.vsix"

    Installs the extension provided by the VSIX file.
#>
function Install-AzureDataStudioExtension {
    [CmdletBinding()]
    param(
        # Full path to the VSIX of the Azure Data Studio extension.
        [Parameter(Mandatory = $true)]
        [string]$extensionId
    )

    function InstallExtension($installLocation, $executablePath) {
        if (!$installLocation) {
            return
        }

        Write-Verbose "Azure Data Studio installation found at $installLocation"
    
        Write-Host "Installing Azure Data Studio extension $extensionId in $installLocation..."
        Start-ChocolateyProcessAsAdmin -ExeToRun $installLocation -Statements "--install-extension",$extensionId -Elevated:$false
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

    InstallExtension $installLocationSystemLevel $extensionId
    InstallExtension $installLocationUserLevel $extensionId
    InstallExtension $installLocationInsidersSystemLevel $extensionId
    InstallExtension $installLocationInsidersUserLevel $extensionId
}
