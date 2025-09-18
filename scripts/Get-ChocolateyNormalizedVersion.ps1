function Get-ChocolateyNormalizedVersion {
  <#
    .SYNOPSIS
      Converts a version to a Chocolatey CLI 2.x+ compatible normalized version.

    .DESCRIPTION
      Uses the NugetVersionExtensions contained in the installed version of Chocolatey to
      convert a given version to the normalized version that will be packed by Chocolatey.

    .EXAMPLE
      Get-ChocolateyNormalizedVersion "25.03"
  #>
  [CmdletBinding()]
  param(
    [string]$Version
  )

  if (-not ('Chocolatey.NugetVersionExtensions' -as [type])) {
    try {
        Add-Type -AssemblyName $env:ChocolateyInstall\choco.exe
    } catch {
        $null = [System.Reflection.Assembly]::Loadfrom("$env:ChocolateyInstall\choco.exe")
    }
  }

  [Chocolatey.NugetVersionExtensions]::ToNormalizedStringChecked($Version)
}