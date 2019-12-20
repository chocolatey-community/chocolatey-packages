$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = $env:chocolateyPackageName
  fileType               = 'EXE'
  url                    = 'https://lockhunter.com/assets/exe/lockhuntersetup_3-3-4.exe'
  checksum               = 'A91CA5B5D4517666F65A43E39DA56FDD6C13E1BCB9F22FAD1790ACC5326680C6'
  checksumType           = 'sha256'
  silentArgs             = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
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
