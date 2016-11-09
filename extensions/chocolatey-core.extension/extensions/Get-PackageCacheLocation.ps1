<#
.SYNOPSIS
    Get temporary location for the package based on its name and version.

.DESCRIPTION
    The function returns package cache directory within $Env:TEMP. It will not create the directory
    if it doesn't exist.

.EXAMPLE
    Get-PackageCacheLocation

.OUTPUTS
    [String]
#>
function Get-PackageCacheLocation {
    [CmdletBinding()]
    param (
        # Name of the package, by default $Env:ChocolateyPackageName
        [string] $Name    = $Env:ChocolateyPackageName,
        # Version of the package, by default $Env:ChocolateyPackageVersion
        [string] $Version = $Env:ChocolateyPackageVersion
    )

    if (!$Name) { Write-Warning 'Environment variable $Env:ChocolateyPackageName is not set' }
    $res = Join-Path $Env:TEMP $Name

    if (!$Version) { Write-Warning 'Environment variable $Env:ChocolateyPackageVersion is not set' }
    $res = Join-Path $packageTemp $Version

    $res
}
