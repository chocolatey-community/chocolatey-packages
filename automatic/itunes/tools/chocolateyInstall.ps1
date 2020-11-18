$ErrorActionPreference = 'Stop';

$version = '12.11.0.26'

$packageArgs = @{
  packageName    = 'iTunes'
  fileType       = 'msi'
  url            = 'https://secure-appldnld.apple.com/itunes12/001-82544-20201113-960CA068-25EC-11EB-A1F0-EFB0133BD450/iTunesSetup.exe'
  url64bit       = 'https://secure-appldnld.apple.com/itunes12/001-82541-20201113-960CFAAE-25EC-11EB-864A-F0B0133BD450/iTunes64Setup.exe'
  softwareName   = 'iTunes'
  checksum       = '3EC3C7B867369040347C291DA4601D7B121045C505EAA687608E03A53E65872F'
  checksumType   = 'sha256'
  checksum64     = 'fff4a32a59b2d78eb2807800d30a05e0b14d1b16dfb70ff0eae20b5a45079fa7'
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
