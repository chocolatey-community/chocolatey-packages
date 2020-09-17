$ErrorActionPreference = 'Stop';

$version = '12.10.9.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/001-37027-20200915-5CBE9AC0-F7A0-11EA-96A7-8DB5DD073FF6/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/001-37026-20200915-5CBD39A0-F7A0-11EA-BB8F-8EB5DD073FF6/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '0365234E61110F191196C559E96541DEDC5C3D358A52347D0EE90FA7338B4214'
  checksumType   = 'sha256'
  checksum64     = '2a4bae8cc0c0287d9d7a5359082760f00b5038d27a565b46bda81518a0bdd5d7'
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
