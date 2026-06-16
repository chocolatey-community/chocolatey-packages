$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:chocolateyPackageName
  fileType       = 'EXE'
  url            = 'https://lockhunter.com/assets/exe/lockhuntersetup_3-4-3.exe'
  checksum       = '2BA380C9A643CAF04A17F41D22722595BC3B62BF1855D5DE04816F1D1C2DBEA9'
  checksumType   = 'sha256'
  silentArgs     = "/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`""
  validExitCodes = @(0)
  softwareName   = 'LockHunter*'
}
Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation) { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"

Install-BinFile $packageName "$installLocation\$packageName.exe"
