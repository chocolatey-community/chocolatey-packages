$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$filePath  = "$toolsPath\picard_x32.exe"

$packageArgs = @{
  packageName    = 'picard'
  fileType       = 'exe'
  softwareName   = 'MusicBrainz Picard'
  silentArgs     = '/S'
  validExitCodes = @(0)
}

[array]$key = Get-UninstallRegistryKey $packageArgs.softwareName
if ($key.Count -eq 1) {
    Write-Host "Previous installation detected, uninstalling"
    $packageArgs.file = $key[0].UninstallString
    Uninstall-ChocolateyPackage @packageArgs
}
$packageArgs.file = $filePath
Install-ChocolateyInstallPackage @packageArgs
Remove-Item -Force -ea 0 $filePath,"$filePath.ignore"
