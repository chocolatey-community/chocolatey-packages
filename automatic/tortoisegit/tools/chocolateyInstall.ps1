$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

[version] $softwareVersion = '2.16.0.0'
$installedVersion = Get-InstalledVersion

if ($installedVersion -and ($softwareVersion -eq $installedVersion) -and !$env:ChocolateyForce) {
  Write-Host "TortoiseGit v$installedVersion is already installed - skipping download and installation."
}
else {
  $packageArgs = @{
    PackageName    = 'tortoisegit'
    FileType       = 'msi'
    SoftwareName   = 'TortoiseGit*'
    File           = "$toolsPath\TortoiseGit-2.16.0.0-32bit.msi"
    File64         = "$toolsPath\TortoiseGit-2.16.0.0-64bit.msi"
    SilentArgs     = '/quiet /qn /norestart REBOOT=ReallySuppress'
    ValidExitCodes = @(0, 3010)
  }

  Install-ChocolateyInstallPackage @packageArgs
}

# Lets remove the installer as there is no more need for it.
Remove-Item -Force "$toolsPath\*.msi" -ea 0
