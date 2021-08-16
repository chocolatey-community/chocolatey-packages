$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = $env:chocolateyPackageName
  fileType       = 'EXE'
  url            = 'https://lockhunter.com/assets/exe/lockhuntersetup_3-4-2.exe'
  checksum       = 'ceccb8a91ff02b64ec45c0718f292759ce6f49cb7a8dff934111e69a454e3778'
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
