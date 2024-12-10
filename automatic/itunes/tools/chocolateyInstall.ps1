$ErrorActionPreference = 'Stop';

$version = '12.13.4.4'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/072-08831-20241021-59E04F71-9D64-4CE7-978C-1A37574B78E4/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/072-08832-20241021-5BCDE100-420E-4BEF-A8C7-16A8E499B7D3/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'A037A56E7535380DDA167FF8D47D76295031D4C44FA87747BA199EB47B3BC641'
  checksumType   = 'sha256'
  checksum64     = 'b3d7c02032ae6ae3649914f70803e21f791b5399e2ff201fbcefad1dc059c192'
  checksumType64 = 'sha256'
  silentArgs     = "/qn /norestart"
  validExitCodes = @(0, 2010, 1641, 3010)
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
