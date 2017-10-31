$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'sidesync'
  fileType               = 'exe'
  url                    = 'http://downloadcenter.samsung.com/content/SW/201710/20171031152920648/SideSync_4.7.5.203.exe'
  checksum               = '3156e01f5dfc26d6f9d795000305acac8c3368d687cbdfa144d9bd74968de2f1'
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
