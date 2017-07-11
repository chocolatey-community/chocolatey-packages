$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = 'lockhunter'
  fileType               = 'EXE'
  url                    = 'http://lockhunter.com/exe/lockhuntersetup_3-1-1.exe'
  url64Bit               = 'http://lockhunter.com/exe/lockhuntersetup_3-1-1.exe'
  checksum               = 'adea78761f18baaf938f9b5a18ee3b07cb6426f8adfa234f715630741130ee7d'
  checksum64             = 'adea78761f18baaf938f9b5a18ee3b07cb6426f8adfa234f715630741130ee7d'
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
