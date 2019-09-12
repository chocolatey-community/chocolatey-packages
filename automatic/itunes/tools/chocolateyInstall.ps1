$ErrorActionPreference = 'Stop';

$version = '12.10.0.7'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/061-00119-20190909-68198A32-D33F-11E9-B2F6-6093B44B725A/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/061-00117-20190909-68198B5E-D33F-11E9-B2F6-6193B44B725A/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'B4B856E43566EF19A1924BE7B986C0C2B3D6201EE0AA29701D34DF60BEE94653'
  checksumType   = 'sha256'
  checksum64     = '05ce8332c5eef37239e9805311cdaa5ce095d77799b1930d78c3c3d5175c0927'
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
