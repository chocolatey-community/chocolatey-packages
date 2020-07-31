$ErrorActionPreference = 'Stop';

$version = '12.10.8.5'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/001-11169-20200729-C90BF860-D1E1-11EA-800D-D3A4EF84CA04/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/001-11171-20200729-C90BA68A-D1E1-11EA-9F72-FBF01D14DEAA/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = 'C54BA51E3D3AB4CB75D5AE45A4D143FBD02E20B61A452880247528BC8F7CD512'
  checksumType   = 'sha256'
  checksum64     = '3ba6a2c78a0fdc4bb211a5e8c0c39e186421085f4252e257b94fa13cb7ed3420'
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
