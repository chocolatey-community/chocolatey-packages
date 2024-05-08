$ErrorActionPreference = 'Stop';

$version = '12.13.2.3'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/052-51519-20240506-10EAEE2C-0BF2-11EF-B073-701B25942342/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/052-51516-20240506-351B8BFB-C5A7-4FD8-8262-60CD9FAA1464/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '145A32239B2DA5048920F46367FDC672DAA91C66CBFBFF039678B0E878791D3F'
  checksumType   = 'sha256'
  checksum64     = '9cbaef01a8e2be6f4aa68768484268def7ca71491b71e56b435d4878da3232fd'
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
