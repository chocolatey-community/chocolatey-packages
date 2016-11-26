$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'pcwrunas'
  fileType               = 'EXE'
  url                    = 'http://download.pcwelt.de/area_release/files/A1/59/A159789BD5C889445B1D33BBF89685BC/pcwRunAs4.exe'
  checksum               = '752069509a8887361d1b830f59e08bab5c5cb67b01d4ab263d6d8c5dd0921acd'
  checksumType           = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'pcwRunAs *'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Install-BinFile $packageName $installLocation\pcwRunAs4.exe
}
else { Write-Warning "Can't find $packageName install location" }
