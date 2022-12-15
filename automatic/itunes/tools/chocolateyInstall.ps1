$ErrorActionPreference = 'Stop';

$version = '12.12.7.1'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/032-11200-20221212-DF5B507C-24FF-4C3B-914A-7A161CC389B2/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/032-11199-20221212-7680817F-9CEC-4DD3-9191-8D0C20E8A548/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '6FEC6605A0166E60F4D931DC308A444280C88BFDCC93C095DA320C43D5C6EADC'
  checksumType   = 'sha256'
  checksum64     = '6e2f30a48fea70d04a302d19a33b4fde3dbabe4ef9ac3205e2d91d8692298cae'
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
