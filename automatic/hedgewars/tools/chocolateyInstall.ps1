$ErrorActionPreference = 'Stop'

$toolsPath   = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName            = 'hedgewars'
  fileType               = 'exe'
  url                    = 'http://download.gna.org/hedgewars/Hedgewars-0.9.22.exe'
  url64bit               = 'http://download.gna.org/hedgewars/Hedgewars-0.9.22.exe'
  checksum               = '42716d965037ae67022331f7ed1972e2a0289e97cee59df7b3bcc71de041180c'
  checksum64             = ''
  checksumType           = 'sha256'
  silentArgs             = '/S'
  validExitCodes         = @(0)
  softwareName           = 'hedgewars*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
