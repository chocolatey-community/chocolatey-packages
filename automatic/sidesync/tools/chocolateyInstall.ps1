$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'sidesync'
  fileType               = 'exe'
  url                    = 'http://downloadcenter.samsung.com/content/SW/201704/20170406144442618/SideSync_4.7.5.48.exe'
  checksum               = 'ea0d4b03f7a34a1e8dd990260385df4880d8dec41f45376cdb3bf1d664091211'
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
