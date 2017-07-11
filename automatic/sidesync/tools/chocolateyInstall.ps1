$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'sidesync'
  fileType               = 'exe'
  url                    = 'http://downloadcenter.samsung.com/content/SW/201706/20170612130426872/SideSync_4.7.5.114.exe'
  checksum               = '7512d5fe30674d667b5b0127feff7b68d683dcaa6b67891ec0e8eb902afc5bdd'
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
