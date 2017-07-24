$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lockhunter'
  fileType               = 'EXE'
  url                    = 'https://lockhunter.com/exe/lockhuntersetup_3-2-3.exe'
  url64Bit               = 'https://lockhunter.com/exe/lockhuntersetup_3-2-3.exe'
  checksum               = '59E7051CB079BE49AC2BB4DD44CBDB6D4E11B6466D779465C7D1A3CA59272663'
  checksum64             = '59E7051CB079BE49AC2BB4DD44CBDB6D4E11B6466D779465C7D1A3CA59272663'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/VERYSILENT'
  validExitCodes         = @(0)
  softwareName           = 'LockHunter*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"

Install-BinFile $packageName "$installLocation\$packageName.exe"
