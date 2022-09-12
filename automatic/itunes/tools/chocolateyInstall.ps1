$ErrorActionPreference = 'Stop';

$version = '12.12.5.8'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/012-67784-20220909-258DB4D7-2141-4853-BAE8-1C21EECA32EE/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/012-67782-20220909-091C2557-7D04-4926-AD36-CE1EC201A92D/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'A0694F030490C7BF96403D30116478F9FF573662CA8FA020D6A4238D6934B768'
  checksumType   = 'sha256'
  checksum64     = '97584c3e1e3d7cedec144915ddf516adfabf4e8219bca60fd02961ebeedbb46c'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641)
  unzipLocation  = Get-PackageCacheLocation
}

$app = Get-UninstallRegistryKey -SoftwareName $packageArgs.softwareName | Select-Object -first 1

if ($app -and ([version]$app.DisplayVersion -ge [version]$version) -and ($env:ChocolateyForce -ne $true)) {
  Write-Host "iTunes $version or higher is already installed."
  Write-Host "No need to download and install again"
  return;
}

Install-ChocolateyZipPackage @packageArgs

$msiFileList = (Get-ChildItem -Path $packageArgs.unzipLocation -Filter '*.msi' | Where-Object {
  $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
})

foreach ($msiFile in $msiFileList) {
  $packageArgs.packageName = $msiFile.Name
  $packageArgs.file = $msiFile.FullName
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item $packageArgs.unzipLocation -Recurse -Force -ea 0
