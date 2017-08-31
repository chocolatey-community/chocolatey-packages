$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'sidesync'
  fileType               = 'exe'
  url                    = 'http://downloadcenter.samsung.com/content/SW/201708/20170828104208391/SideSync_4.7.5.181.exe'
  checksum               = '7e65bca1be1e78c87868d5e3788a667d1ed39ce6cd8b4c75fd3d218975cab6f7'
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'Samsung SideSync'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"
